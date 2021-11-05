unit Cadastro.Model.XML;

interface

uses
  Cadastro.Model.Interfaces, System.Classes, XMLDoc;

type

  TModelXML = Class(TInterfacedObject, iXML)
    private
       FCliente: iCliente;
       FXMLDoc: TXMLDocument;
       FXMLStream: TMemoryStream;
    public
       Constructor Create;
       Destructor  Destroy; override;
       Class Function New: iXML;

       function SetCliente(Value: iCliente): iXML;
       function Gerar: iXML;
       function GetXML: TMemoryStream;
  End;

implementation

uses
  System.SysUtils, Xml.XMLIntf, Vcl.Dialogs;

{ TModelXML }

constructor TModelXML.Create;
begin
    FXMLDoc := TXMLDocument.Create(Nil);
    FXMLStream := TMemoryStream.Create;
end;

destructor TModelXML.Destroy;
begin
     FreeAndNil(FXMLStream);
  inherited;
end;

function TModelXML.Gerar: iXML;
Var
   lNodeRoot: IXMLNode;
   lNodeClientes: IXMLNode;
   lNodeCliente: IXMLNode;
begin
    try
       With FXMLDoc do
       begin
           XML.Clear;
           Options := Options + [doNodeAutoIndent];
           Active := True;
           Version := '1.0';
           Encoding := 'UTF-8';
           lNodeRoot := AddChild('CADASTRO');
           lNodeClientes := lNodeRoot.AddChild('Cliente');

           lNodeCliente := lNodeClientes.AddChild('Nome');
           lNodeCliente.Text := FCliente.GetNome;

           lNodeCliente := lNodeClientes.AddChild('Identidade');
           lNodeCliente.Text := FCliente.GetIdentidade;

           lNodeCliente := lNodeClientes.AddChild('CPF');
           lNodeCliente.Text := FCliente.GetCPF;

           lNodeCliente := lNodeClientes.AddChild('Telefone');
           lNodeCliente.Text := FCliente.GetTelefone;

           lNodeCliente := lNodeClientes.AddChild('Email');
           lNodeCliente.Text := FCliente.GetEmail;

           lNodeCliente := lNodeClientes.AddChild('CEP');
           lNodeCliente.Text := FCliente.GetCEP;

           lNodeCliente := lNodeClientes.AddChild('Logradouro');
           lNodeCliente.Text := FCliente.GetLogradouro;

           lNodeCliente := lNodeClientes.AddChild('Número');
           lNodeCliente.Text := FCliente.GetNumero;

           lNodeCliente := lNodeClientes.AddChild('Complemento');
           lNodeCliente.Text := FCliente.GetComplemento;

           lNodeCliente := lNodeClientes.AddChild('Bairro');
           lNodeCliente.Text := FCliente.GetBairro;

           lNodeCliente := lNodeClientes.AddChild('Cidade');
           lNodeCliente.Text := FCliente.GetCidade;

           lNodeCliente := lNodeClientes.AddChild('Estado');
           lNodeCliente.Text := FCliente.GetEstado;

           lNodeCliente := lNodeClientes.AddChild('País');
           lNodeCliente.Text := FCliente.GetPais;

           SaveToStream(FXMLStream);
           FXMLStream.Position := 0;
       end;

    Except on E: Exception do
        Showmessage('Erro: ' + E.Message)
    end;
end;

function TModelXML.GetXML: TMemoryStream;
begin
  Result := FXMLStream;
end;

class function TModelXML.New: iXML;
begin
   Result := Self.Create;
end;

function TModelXML.SetCliente(Value: iCliente): iXML;
begin
   Result := Self;
   FCliente := Value;
end;

end.
