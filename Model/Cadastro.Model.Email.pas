unit Cadastro.Model.Email;

interface

uses
  Cadastro.Model.Interfaces, IdSSLOpenSSL, IdMessageParts,
  IdAttachment, IdAttachmentMemory, IdText, IdSMTP,
  IdExplicitTLSClientServerBase, IdSASLLogin, IdAttachmentFile;

type

   TModelEMail = Class(TInterfacedObject, iEmail)
      private
          FIdSMTP      : TIdSMTP;
          FIdSocketSSL : TIdSSLIOHandlerSocketOpenSSL;
          FConectado   : Boolean;
          FAutenticado : Boolean;
          FRemetente   : String;
          FAssunto     : String;
          FUsuario     : String;
          FSenha       : String;
          FCorpoEmail  : String;
          FAtivarSSL   : Boolean;
          FSucesso     : Boolean;
          FErro        : String;
          FCliente     : iCliente;

          procedure   OnDesconectado(Sender: TObject);
          procedure   OnConectado(Sender: TObject);
          procedure   PrepararMensagem;
          function    Autenticar: Boolean;
          function    Conectar: Boolean;
          procedure   Desconectar;
      public
         Constructor Create(pDadosConexao: TDadosConexao);
         Destructor  Destroy; override;
         Class Function New(pDadosConexao: TDadosConexao): iEmail;

         function SetCliente(Value: iCliente): iEmail;
         function GetSucesso: Boolean;
         function Enviar: iEmail;
         function GetErro: String;
   End;

implementation

uses
  System.SysUtils, IdMessage, System.AnsiStrings, Cadastro.Model.XML;

{ TModelEMail }

function TModelEMail.Autenticar: Boolean;
begin
  Result := False;
  Try
    FIdSMTP.Username := FUsuario;
    FIdSMTP.Password := FSenha;
    if FIdSMTP.Authenticate then
       Result := True;
  Except ON E: Exception do
    FErro := 'ERRO: ' + E.Message;
  End;
end;

function TModelEMail.SetCliente(Value: iCliente): iEmail;
begin
   Result := Self;
   FCliente := Value;
end;

function TModelEMail.Conectar: Boolean;
begin
    Result           := False;
    FIdSMTP.AuthType := satDefault;
    FIdSMTP.UseEhlo  := True; //Verifica se o servidor suporta STARTTLS
    FIdSMTP.ValidateAuthLoginCapability := True;
    if FAtivarSSL then
    begin
       FIdSocketSSL.SSLOptions.Method := sslvSSLv23;
       FIdSocketSSL.SSLOptions.Mode   := sslmUnassigned;
       FIdSMTP.IOHandler              := FIdSocketSSL;
       FIdSMTP.UseTLS                 := utUseRequireTLS
    end;
    Try
        FIdSMTP.Connect;
        Result := True;
      Except ON E: Exception do
      begin
         if Not (AnsiContainsStr(E.Message,'10038')) AND (E.Message <> 'Not Connected') AND
            (E.Message <> 'Disconnected.') AND (E.Message <> 'Connection Closed Gracefully.') then
            FErro := 'ERRO: ' + E.Message;
      end;
    End;
end;

Constructor TModelEMail.Create(pDadosConexao: TDadosConexao);
begin
   FIdSMTP                := TIdSMTP.Create(Nil);
   FIdSMTP.ConnectTimeout := 3000;
   FIdSMTP.ReadTimeout    := 50000;
   FIdSocketSSL           := TIdSSLIOHandlerSocketOpenSSL.Create(Nil);
   FIdSMTP.OnConnected    := OnConectado;
   FIdSMTP.OnDisconnected := OnDesconectado;
   FConectado             := False;
   FSucesso               := False;
   FErro                  := '';
   FIdSMTP.Host           := pDadosConexao.Host;
   FIdSMTP.Port           := pDadosConexao.Porta;
   FUsuario               := pDadosConexao.Usuario;
   FSenha                 := pDadosConexao.Senha;
   FRemetente             := pDadosConexao.Remetente;
   FAutenticado           := pDadosConexao.Autenticado;
   FAtivarSSL             := pDadosConexao.AtivarSSL;
   FAssunto               := 'Confirmação de Cadastro.';
end;

procedure TModelEMail.Desconectar;
begin
   if FConectado then
      FIdSMTP.Disconnect;
end;

destructor TModelEMail.Destroy;
begin
    FreeAndNil(FIdSMTP);
    FreeAndNil(FIdSocketSSL);
  inherited;
end;

function TModelEMail.Enviar: iEmail;
Var
   lIdMsg  : TIdMessage;
   lXML: iXML;
begin
   if Not Conectar then
      Exit;

   if FAutenticado then
   begin
       if Not Autenticar then
          Exit;
   end;

   lXML := TModelXML.New;
   lXML.SetCliente(FCliente)
       .Gerar;

   PrepararMensagem;

   lIdMsg := TIdMessage.Create(Nil);
   lIdMsg.Clear;
   Try
     Try
        with lIdMsg do
        begin
            From.Address := FUsuario;
            //Caso nao utilize autenticação utiliza o nome do host como remetente
            if From.Address = '' then
               From.Address := 'semremetente@' + FIdSMTP.Host;

            From.Name    := 'Cadastro de Clientes';
            Recipients.Clear;
            Recipients.Add.Address := FCliente.GetEmail;
            Subject := FAssunto;
            Body.Clear;
        end;
        With TIdText.Create(lIdMsg.MessageParts) do
        begin
           ContentType := 'text/html; charset=iso-8859-1';
           Body.Text   := FCorpoEmail;
        end;

        with TIdAttachmentMemory.Create(lIdMsg.MessageParts, lXML.GetXML) do
        begin
          ContentType := 'application/xml';
          Name := 'Cadastro.xml';
          FileName := 'Cadastro.xml';
          ContentDescription := 'Arquivo Anexo: Cadastro.xml';
        end;

        FIdSMTP.Send(lIdMsg);
        FSucesso := True;

     Except ON E: Exception do
          FErro := 'ERRO: ' + E.Message;
     End;
   Finally
      FreeAndNil(lIdMsg);
   End;

end;

function TModelEMail.GetErro: String;
begin
   Result := FErro;
end;

class Function TModelEMail.New(pDadosConexao: TDadosConexao): iEmail;
begin
   Result := Self.Create(pDadosConexao);
end;

procedure TModelEMail.OnConectado(Sender: TObject);
begin
    FConectado := True;
end;

procedure TModelEMail.OnDesconectado(Sender: TObject);
begin
    FConectado := False;
end;

procedure TModelEMail.PrepararMensagem;
begin
   FAssunto      := 'E-mail de Confirmação de Cadastro!';
   FCorpoEmail   := '<b>           Seu Cadastro foi Realizado com Sucesso!!</b>' +
                    '<br>' +
                    '<br>' +
                    '<table>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Nome:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetNome + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Identidade:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetIdentidade + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>CPF:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetCPF + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Telefone:</b></td> ' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetTelefone + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Email:</b></td> ' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetEmail + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>CEP:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetCEP + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Logradouro:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetLogradouro + '</b></td>' +
                    '    </tr>' +
                    '    <tr> ' +
                    '       <td width="100" align="Right"><b>Numero:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetNumero + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Complemento:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetComplemento + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Bairro:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetBairro + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Cidade:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetCidade + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Estado:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetEstado + '</b></td>' +
                    '    </tr>' +
                    '    <tr>' +
                    '       <td width="100" align="Right"><b>Pais:</b></td>' +
                    '       <td width="400" align="Left"><b>' + FCliente.GetPais + '</b></td>' +
                    '    </tr>' +
                    '</table> ' +
                    '<br><b>Att.:' +
                    '<br>Cadastro de Clientes</b>';
end;

function TModelEMail.GetSucesso: Boolean;
begin
   Result := FSucesso;
end;

end.
