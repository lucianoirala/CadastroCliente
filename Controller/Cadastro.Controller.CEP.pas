unit Cadastro.Controller.CEP;

interface

uses
  Cadastro.Model.Interfaces;

type

  TControllerCEP = Class(TInterfacedObject, iCEP)
     private
        FCEP: iCEP;
     public
        Constructor Create;
        Destructor  Destroy; override;
        Class Function New: iCEP;

        function Logradouro: String;
        function Complemento: String;
        function Bairro: String;
        function Cidade: String;
        function Estado: String;
        function SetCEP(Value: String): iCEP;
        function Consultar: iCEP;
  End;

implementation

uses
  Cadastro.Model.CEP;

{ TControllerCEP }

function TControllerCEP.Bairro: String;
begin
   Result := FCep.Bairro;
end;

function TControllerCEP.Cidade: String;
begin
   Result := FCep.Cidade;
end;

function TControllerCEP.Complemento: String;
begin
   Result := FCep.Complemento;
end;

function TControllerCEP.Consultar: iCEP;
begin
   Result := Self;
   FCep.Consultar;
end;

constructor TControllerCEP.Create;
begin
   FCep := TModelCEP.New;
end;

destructor TControllerCEP.Destroy;
begin

  inherited;
end;

function TControllerCEP.Estado: String;
begin
   Result := FCep.Estado;
end;

function TControllerCEP.Logradouro: String;
begin
   Result := FCep.Logradouro;
end;

class function TControllerCEP.New: iCEP;
begin
   Result := Self.Create;
end;

function TControllerCEP.SetCEP(Value: String): iCEP;
begin
   Result := Self;
   FCep.SetCEP(Value);
end;

end.
