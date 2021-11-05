unit Cadastro.Controller.Cliente;

interface

uses
  Cadastro.Model.Interfaces;

type

  TControllerCliente = Class(TInterfacedObject, iCliente)
     private
        FCliente: iCliente;
     public
        Constructor Create;
        Destructor  Destroy; override;
        Class Function New: iCliente;

        function SetNome(Value: String): iCliente;
        function SetIdentidade(Value: String): iCliente;
        function SetCPF(Value: String): iCliente;
        function SetTelefone(Value: String): iCliente;
        function SetEmail(Value: String): iCliente;
        function SetCEP(Value: String): iCliente;
        function SetLogradouro(Value: String): iCliente;
        function SetNumero(Value: String): iCliente;
        function SetComplemento(Value: String): iCliente;
        function SetBairro(Value: String): iCliente;
        function SetCidade(Value: String): iCliente;
        function SetEstado(Value: String): iCliente;
        function SetPais(Value: String): iCliente;
        function GetNome: String;
        function GetIdentidade: String;
        function GetCPF: String;
        function GetTelefone: String;
        function GetEmail: String;
        function GetCEP: String;
        function GetLogradouro: String;
        function GetNumero: String;
        function GetComplemento: String;
        function GetBairro: String;
        function GetCidade: String;
        function GetEstado: String;
        function GetPais: String;
        function Salvar: iCliente;
        function Sucesso: Boolean;
  End;

implementation

uses
  Cadastro.Model.Cliente;

{ TControllerCliente }

constructor TControllerCliente.Create;
begin
   FCliente := TModelCliente.New;
end;

destructor TControllerCliente.Destroy;
begin

  inherited;
end;

function TControllerCliente.GetBairro: String;
begin
   Result := FCliente.GetBairro;
end;

function TControllerCliente.GetCEP: String;
begin
   Result := FCliente.GetCEP;
end;

function TControllerCliente.GetCidade: String;
begin
   Result := FCliente.GetCidade;
end;

function TControllerCliente.GetComplemento: String;
begin
   Result := FCliente.GetComplemento;
end;

function TControllerCliente.GetCPF: String;
begin
   Result := FCliente.GetCPF;
end;

function TControllerCliente.GetEmail: String;
begin
   Result := FCliente.GetEmail;
end;

function TControllerCliente.GetEstado: String;
begin
   Result := FCliente.GetEstado;
end;

function TControllerCliente.GetIdentidade: String;
begin
   Result := FCliente.GetIdentidade;
end;

function TControllerCliente.GetLogradouro: String;
begin
   Result := FCliente.GetLogradouro;
end;

function TControllerCliente.GetNome: String;
begin
   Result := FCliente.GetNome;
end;

function TControllerCliente.GetNumero: String;
begin
   Result := FCliente.GetNumero;
end;

function TControllerCliente.GetPais: String;
begin
   Result := FCliente.GetPais;
end;

function TControllerCliente.GetTelefone: String;
begin
   Result := FCliente.GetTelefone;
end;

class function TControllerCliente.New: iCliente;
begin
   Result := Self.Create;
end;

function TControllerCliente.Salvar: iCliente;
begin
   Result := Self;
   FCliente.Salvar;
end;

function TControllerCliente.SetBairro(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetBairro(Value);
end;

function TControllerCliente.SetCEP(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetCEP(Value);
end;

function TControllerCliente.SetCidade(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetCidade(Value);
end;

function TControllerCliente.SetComplemento(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetComplemento(Value);
end;

function TControllerCliente.SetCPF(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetCPF(Value);
end;

function TControllerCliente.SetEmail(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetEmail(Value);
end;

function TControllerCliente.SetEstado(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetEstado(Value);
end;

function TControllerCliente.SetIdentidade(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetIdentidade(Value);
end;

function TControllerCliente.SetLogradouro(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetLogradouro(Value);
end;

function TControllerCliente.SetNome(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetNome(Value);
end;

function TControllerCliente.SetNumero(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetNumero(Value);
end;

function TControllerCliente.SetPais(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetPais(Value);
end;

function TControllerCliente.SetTelefone(Value: String): iCliente;
begin
   Result := Self;
   FCliente.SetTelefone(Value);
end;

function TControllerCliente.Sucesso: Boolean;
begin
   Result := FCliente.Sucesso;
end;

end.
