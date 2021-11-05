unit Cadastro.Model.Cliente;

interface

uses
  Cadastro.Model.Interfaces;

type

  TModelCliente = Class(TInterfacedObject, iCliente)
     private
        FModelEmail: iEmail;
        FNome: String;
        FIdentidade: String;
        FCPF: String;
        FTelefone: String;
        FEmail: String;
        FCEP: String;
        FLogradouro: String;
        FNumero: String;
        FComplemento: String;
        FBairro: String;
        FCidade: String;
        FEstado: String;
        FPais: String;
        FSucesso: Boolean;
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
  Cadastro.Model.Email;

{ TModelCliente }

constructor TModelCliente.Create;
begin

end;

destructor TModelCliente.Destroy;
begin

  inherited;
end;

function TModelCliente.GetBairro: String;
begin
   Result := FBairro;
end;

function TModelCliente.GetCEP: String;
begin
   Result := FCEP;
end;

function TModelCliente.GetCidade: String;
begin
   Result := FCidade;
end;

function TModelCliente.GetComplemento: String;
begin
   Result := FComplemento;
end;

function TModelCliente.GetCPF: String;
begin
   Result := FCPF;
end;

function TModelCliente.GetEmail: String;
begin
   Result := FEmail;
end;

function TModelCliente.GetEstado: String;
begin
   Result := FEstado;
end;

function TModelCliente.GetIdentidade: String;
begin
   Result := FIdentidade;
end;

function TModelCliente.GetLogradouro: String;
begin
   Result := FLogradouro;
end;

function TModelCliente.GetNome: String;
begin
   Result := FNome;
end;

function TModelCliente.GetNumero: String;
begin
   Result := FNumero;
end;

function TModelCliente.GetPais: String;
begin
   Result := FPais;
end;

function TModelCliente.GetTelefone: String;
begin
   Result := FTelefone;
end;

class function TModelCliente.New: iCliente;
begin
   Result := Self.Create;
end;

function TModelCliente.Salvar: iCliente;
begin
   //Implementação futura como opção, Salvar em Banco de Dados
end;

function TModelCliente.SetBairro(Value: String): iCliente;
begin
   Result := Self;
   FBairro := Value;
end;

function TModelCliente.SetCEP(Value: String): iCliente;
begin
   Result := Self;
   FCEP := Value;
end;

function TModelCliente.SetCidade(Value: String): iCliente;
begin
   Result := Self;
   FCidade := Value;
end;

function TModelCliente.SetComplemento(Value: String): iCliente;
begin
   Result := Self;
   FComplemento := Value;
end;

function TModelCliente.SetCPF(Value: String): iCliente;
begin
   Result := Self;
   FCPF := Value;
end;

function TModelCliente.SetEmail(Value: String): iCliente;
begin
   Result := Self;
   FEmail := Value;
end;

function TModelCliente.SetEstado(Value: String): iCliente;
begin
   Result := Self;
   FEstado := Value;
end;

function TModelCliente.SetIdentidade(Value: String): iCliente;
begin
   Result := Self;
   FIdentidade := Value;
end;

function TModelCliente.SetLogradouro(Value: String): iCliente;
begin
   Result := Self;
   FLogradouro := Value;
end;

function TModelCliente.SetNome(Value: String): iCliente;
begin
   Result := Self;
   FNome := Value;
end;

function TModelCliente.SetNumero(Value: String): iCliente;
begin
   Result := Self;
   FNumero := Value;
end;

function TModelCliente.SetPais(Value: String): iCliente;
begin
   Result := Self;
   FPais := Value;
end;

function TModelCliente.SetTelefone(Value: String): iCliente;
begin
   Result := Self;
   FTelefone := Value;
end;

function TModelCliente.Sucesso: Boolean;
begin
   Result := FSucesso;
end;

end.

