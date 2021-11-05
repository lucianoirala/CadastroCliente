unit Cadastro.Controller.Email;

interface

uses
  Cadastro.Model.Interfaces;

type

  TControllerEmail = Class(TInterfacedObject, iEmail)
     private
        FEmail: iEmail;
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
  Cadastro.Model.Email;

{ TControllerEmail }

function TControllerEmail.SetCliente(Value: iCliente): iEmail;
begin
   Result := Self;
   FEmail.SetCliente(Value);
end;

Constructor TControllerEmail.Create(pDadosConexao: TDadosConexao);
begin
   FEmail := TModelEmail.New(pDadosConexao);
end;

destructor TControllerEmail.Destroy;
begin

  inherited;
end;

function TControllerEmail.Enviar: iEmail;
begin
   Result := Self;
   FEmail.Enviar;
end;

function TControllerEmail.GetErro: String;
begin
   Result := FEmail.GetErro;
end;

class Function TControllerEmail.New(pDadosConexao: TDadosConexao): iEmail;
begin
   Result := Self.Create(pDadosConexao);
end;

function TControllerEmail.GetSucesso: Boolean;
begin
  Result := FEmail.GetSucesso;
end;

end.
