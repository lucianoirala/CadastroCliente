unit Cadastro.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Json, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Cadastro.Model.Interfaces, Vcl.Grids, Vcl.Buttons,
  System.ImageList, Vcl.ImgList;

type
  TViewPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    PnlCadastro: TPanel;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    EdtNome: TEdit;
    EdtIdentidade: TEdit;
    EdtCPF: TEdit;
    Panel7: TPanel;
    BtSalva: TButton;
    Label2: TLabel;
    Label4: TLabel;
    EdtTelefone: TEdit;
    EdtEmail: TEdit;
    Label5: TLabel;
    EdtCEP: TEdit;
    Label9: TLabel;
    EdtLogradouro: TEdit;
    Label10: TLabel;
    EdtNumero: TEdit;
    Label11: TLabel;
    EdtComplemento: TEdit;
    Label12: TLabel;
    EdtBairro: TEdit;
    Label13: TLabel;
    EdtCidade: TEdit;
    Label14: TLabel;
    EdtEstado: TEdit;
    Label15: TLabel;
    EdtPais: TEdit;
    BtListar: TButton;
    PnlLista: TPanel;
    BtSair: TButton;
    BtConfigurar: TButton;
    STGLista: TStringGrid;
    btConsultar: TBitBtn;
    ImageList1: TImageList;
    procedure EdtCEPExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtListarClick(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure BtSalvaClick(Sender: TObject);
    procedure BtConfigurarClick(Sender: TObject);
    procedure EdtCPFKeyPress(Sender: TObject; var Key: Char);
    procedure btConsultarClick(Sender: TObject);
  private
    { Private declarations }
    FCep: iCEP;
    FCliente: iCliente;
    FDadosConexao: TDadosConexao;

    procedure ConsultarCEP;
    procedure CarregarCEP;
    procedure LimparCampos;
    procedure ColorirCampo(Sender: TObject);
    function  FormatarCPF(Value: String): String;
    function  ValidarEmail(Value: String): Boolean;
    procedure ListarEnviados;
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

uses
  Cadastro.Controller.CEP, Cadastro.Controller.Cliente,
  Cadastro.Controller.Email, Cadastro.View.ConfiguracaoEmail;

{$R *.dfm}

procedure TViewPrincipal.BtConfigurarClick(Sender: TObject);
Var
  lConfiguracao: TViewConfiguracaoEmail;
begin
  lConfiguracao := TViewConfiguracaoEmail.Create(Nil);
  lConfiguracao.ShowModal;

  With FDadosConexao do
  begin
     Host        := lConfiguracao.Servidor;
     Usuario     := lConfiguracao.Usuario;
     Senha       := lConfiguracao.Senha;
     Porta       := lConfiguracao.Porta;
     Autenticado := lConfiguracao.Autenticado;
     AtivarSSL   := lConfiguracao.AtivarSSL;
     Remetente   := lConfiguracao.Remetente;
  end;

  FreeAndNil(lConfiguracao);

end;

procedure TViewPrincipal.btConsultarClick(Sender: TObject);
begin
    ConsultarCEP;
end;

procedure TViewPrincipal.BtListarClick(Sender: TObject);
begin
    if BtListar.Tag = 0 then
    begin
        PnlCadastro.Visible := False;
        PnlLista.Visible := True;
        BtListar.Caption := 'Voltar';
        BtListar.Tag := 1;
        BtListar.ImageIndex := 4;
    end
    else
    begin
        PnlCadastro.Visible := True;
        PnlLista.Visible := False;
        BtListar.Caption := 'Listar';
        BtListar.Tag := 0;
        BtListar.ImageIndex := 3;
    end;

    BtSalva.Enabled := (BtListar.Tag = 0);
end;

procedure TViewPrincipal.BtSairClick(Sender: TObject);
begin
   Close;
end;

procedure TViewPrincipal.BtSalvaClick(Sender: TObject);
Var
   lEmail: iEmail;
begin
   if Trim(FDadosConexao.Host) = '' then
   begin
      Showmessage('O Servidor de Envio não foi configurado!');
      BtConfigurar.Click;
      Exit;
   end;

   if Not ValidarEmail(EdtEmail.Text) then
   begin
     Showmessage('O Endereço de E-Mail é Inválido!');
     EdtEmail.SetFocus;
     Exit;
   end;

   Try
     Screen.Cursor := crHourGlass;
     BtSalva.Enabled := False;
     FCliente.SetNome(EdtNome.Text)
             .SetIdentidade(EdtIdentidade.Text)
             .SetCPF(EdtCPF.Text)
             .SetTelefone(EdtTelefone.Text)
             .SetEmail(EdtEmail.Text)
             .SetCEP(EdtCEP.Text)
             .SetLogradouro(EdtLogradouro.Text)
             .SetNumero(EdtNumero.Text)
             .SetComplemento(EdtComplemento.Text)
             .SetBairro(EdtBairro.Text)
             .SetCidade(EdtCidade.Text)
             .SetEstado(EdtEstado.Text)
             .SetPais(EdtPais.Text)
             .Salvar;

     lEmail := TControllerEmail.New(FDadosConexao);
     lEmail.SetCliente(FCliente)
           .Enviar;

     if lEmail.GetSucesso then
     begin
        Showmessage('Cliente Cadastro e E-mail enviado com Sucesso!');
        ListarEnviados;
        LimparCampos;
     end
     else
        Showmessage('Não foi possível Enviar o E-mail!');

   Finally
       Screen.Cursor := crDefault;
       BtSalva.Enabled := True;
   End;
end;

procedure TViewPrincipal.CarregarCEP;
begin
   if FCep.Logradouro = '' then
   begin
      Showmessage('O CEP Digitado é inválido!');
      Exit;
   end;

   EdtLogradouro.Text := FCep.Logradouro;
   EdtComplemento.Text:= FCep.Complemento;
   EdtBairro.Text     := FCep.Bairro;
   EdtCidade.Text     := FCep.Cidade;
   EdtEstado.Text     := FCep.Estado;
end;

procedure TViewPrincipal.ColorirCampo(Sender: TObject);
Var
  lCampo: TEdit;
begin
    if (Sender is TEdit) then
    begin
       lCampo := (Sender as TEdit);
       if lCampo.Color = clWindow then
          lCampo.Color := clMoneyGreen
       else
         lCampo.Color := clWindow;
    end;
end;

procedure TViewPrincipal.ConsultarCEP;
Var
  lJSon: TJSONObject;
begin
   if Trim(EdtCEP.Text) = '' then
   begin
      Showmessage('Preencha o Campo CEP para Consultar!');
      EdtCEP.SetFocus;
      Exit;
   end;


   if Length(EdtCEP.Text) < 8 then
   begin
      Showmessage('O CEP é Inválido!');
      Exit;
   end;

   try
     Screen.Cursor := crHourGlass;
     FCep.SetCEP(EdtCEP.Text)
         .Consultar;

     CarregarCEP;
   finally
     Screen.Cursor := crDefault;
   end;

end;

procedure TViewPrincipal.EdtCEPExit(Sender: TObject);
Var
  lJSon: TJSONObject;
begin
   if Length(EdtCEP.Text) < 8 then
   begin
      Showmessage('O CEP é Inválido!');
      Exit;
   end;

   try
     Screen.Cursor := crHourGlass;
     FCep.SetCEP(EdtCEP.Text)
         .Consultar;

     CarregarCEP;
   finally
     Screen.Cursor := crDefault;
   end;
end;

procedure TViewPrincipal.EdtCPFKeyPress(Sender: TObject; var Key: Char);
begin
   if Not (CharInSet(Key, ['0'..'9', Chr(8)])) then
      Key := #0
   else
      if Key <> Chr(8) then
         FormatarCPF('Key');
end;


function TViewPrincipal.FormatarCPF(Value: String): String;
Var
    lTamanho: Integer;
    lTexto: String;
begin
   lTamanho := Length(EdtCPF.Text);
   lTexto   := EdtCPF.Text;

   if lTamanho = 3 then
      EdtCPF.Text := lTexto + '.';

   if lTamanho = 7 then
      EdtCPF.Text := lTexto + '.';


   if lTamanho = 11 then
      EdtCPF.Text := lTexto + '-';

   EdtCPF.SelStart := Length(EdtCPF.Text);
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
var
  I: Integer;
  lLargura: Integer;
begin
    FCep       := TControllerCEP.New;
    FCliente   := TControllerCliente.New;
    Self.Width := 780;

    for I := 0 to Pred(ComponentCount) do
    begin
        if (Components[I] is TEdit) then
        begin
           (Components[I] as TEdit).OnEnter := ColorirCampo;
           (Components[I] as TEdit).OnExit  := ColorirCampo;
        end;

        if (Components[I] is TButton) then
           (Components[I] as TButton).Cursor := crHandPoint;

        if (Components[I] is TBitBtn) then
           (Components[I] as TBitBtn).Cursor := crHandPoint;
    end;

    lLargura := Trunc(STGLista.Width/2);
    lLargura := lLargura + Trunc(lLargura * 0.40);
    STGLista.ColWidths[0] := lLargura;
    STGLista.ColWidths[1] := lLargura;
    STGLista.Cells[0, 0] := 'Nome';
    STGLista.Cells[1, 0] := 'Email';
    ReportMemoryLeaksOnShutdown := True;
end;

procedure TViewPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
     Key := #0;
     Perform(Wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TViewPrincipal.FormShow(Sender: TObject);
begin
   EdtNome.SetFocus;
end;

procedure TViewPrincipal.LimparCampos;
Var
   I: Integer;
begin
   for I := 0 to Pred(ComponentCount) do
   begin
      if (Components[I] is TEdit) then
         (Components[I] as TEdit).Clear;
   end;
end;

procedure TViewPrincipal.ListarEnviados;
Var
  I: Integer;
begin
   I := STGLista.RowCount - 1;
   STGLista.Cells[0, I] := EdtNome.Text;
   STGLista.Cells[1, I] := EdtEmail.Text;
   STGLista.RowCount := STGLista.RowCount + 1;
end;

function TViewPrincipal.ValidarEmail(Value: String): Boolean;
begin
   Result := False;
   Value := Trim(UpperCase(Value));
   if Pos('@', Value) > 1 then
   begin
     Delete(Value, 1, pos('@', Value));
     Result := (Length(Value) > 0) and (Pos('.', Value) > 2);
   end;
end;

end.
