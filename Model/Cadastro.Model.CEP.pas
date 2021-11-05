unit Cadastro.Model.CEP;

interface

uses
  Cadastro.Model.Interfaces, System.JSON;

type

  TModelCEP = Class(TInterfacedObject, iCEP)
     private
        FLogradouro : String;
        FComplemento: String;
        FBairro     : String;
        FCidade     : String;
        FEstado     : String;
        FCEP        : String;
        FJSon       : TJSONObject;

        procedure GetCEP;
        procedure CarregarCEP;

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
  IdHTTP, IdSSLOpenSSL, System.Classes, System.SysUtils;

{ TModelCEP }

function TModelCEP.Bairro: String;
begin
   Result := FBairro;
end;

procedure TModelCEP.CarregarCEP;
begin
   FLogradouro := FJSon.Get('logradouro').JsonValue.Value;
   FComplemento:= FJSon.Get('complemento').JsonValue.Value;
   FBairro     := FJSon.Get('bairro').JsonValue.Value;
   FCidade     := FJSon.Get('localidade').JsonValue.Value;
   FEstado     := FJSon.Get('uf').JsonValue.Value;
end;

function TModelCEP.Cidade: String;
begin
   Result := FCidade;
end;

function TModelCEP.Complemento: String;
begin
   Result := FComplemento;
end;

function TModelCEP.Consultar: iCEP;
begin
   GetCEP;
   if Assigned(FJSon) then
      CarregarCEP;
end;

constructor TModelCEP.Create;
begin

end;

destructor TModelCEP.Destroy;
begin
     FreeAndNil(FJSon);
  inherited;
end;

function TModelCEP.Estado: String;
begin
   Result := FEstado;
end;

procedure TModelCEP.GetCEP;
var
  lHttp: TIdHTTP;
  lHandler: TIdSSLIOHandlerSocketOpenSSL;
  lRetorno: TStringStream;
begin
  lHttp:= TIdHTTP.Create;
  lHandler:= TIdSSLIOHandlerSocketOpenSSL.Create;
  Try
    lHttp.IOHandler := lHandler;
    lHandler.SSLOptions.SSLVersions := [sslvTLSv1];
    lRetorno := TStringStream.Create('');
    lHttp.Get('http://viacep.com.br/ws/' + FCep + '/json/', lRetorno);

    if (lHttp.ResponseCode = 200) AND
       ((Utf8ToAnsi(lRetorno.DataString) <> '{'#$A'  "erro": true'#$A'}')) then
       FJSon := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Utf8ToAnsi(lRetorno.DataString)), 0) as TJSONObject

  Finally
     FreeAndNil(lHttp);
     FreeAndNil(lHandler);
     lRetorno.Destroy;
  End;

end;

function TModelCEP.Logradouro: String;
begin
   Result := FLogradouro;
end;

class function TModelCEP.New: iCEP;
begin
   Result := Self.Create;
end;

function TModelCEP.SetCEP(Value: String): iCEP;
begin
   Result := Self;
   FCep := Value;
end;

end.
