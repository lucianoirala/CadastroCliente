unit Cadastro.Model.Interfaces;

interface

uses
  System.Classes;

type

   TDadosConexao = Record
          Host        : String;
          Usuario     : String;
          Senha       : String;
          Porta       : Integer;
          Autenticado : Boolean;
          AtivarSSL   : Boolean;
          Remetente   : String;
    End;

  iCEP = interface
    ['{7590A5E2-9E84-4DED-842B-DD1866D42B6D}']
    function Logradouro: String;
    function Complemento: String;
    function Bairro: String;
    function Cidade: String;
    function Estado: String;
    function SetCEP(Value: String): iCEP;
    function Consultar: iCEP;
  end;

  iCliente = interface
    ['{3A5F1C5A-77D8-44ED-9D9F-508213E7C3FB}']
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

  end;

  iEmail = interface
    ['{C631D0BA-2661-4911-901B-D956748995E6}']
    function SetCliente(Value: iCliente): iEmail;
    function GetSucesso: Boolean;
    function Enviar: iEmail;
    function GetErro: String;
  end;

  iXML = interface
    ['{6AA45D97-50BF-4996-9012-1E01FB048376}']
    function SetCliente(Value: iCliente): iXML;
    function Gerar: iXML;
    function GetXML: TMemoryStream;
  end;

implementation

end.
