unit Cadastro.View.ConfiguracaoEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, Buttons, iniFiles, IdSMTP;

type
  TViewConfiguracaoEmail = class(TForm)
    Panel1: TPanel;
    LbServidor: TLabel;
    LbPorta: TLabel;
    LbUsuario: TLabel;
    LbSenha: TLabel;
    LbRemetente: TLabel;
    EdtServidor: TEdit;
    EdtPorta: TEdit;
    EdtUsuario: TEdit;
    EdtRemetente: TEdit;
    MskSenha: TMaskEdit;
    CBAutenticacao: TCheckBox;
    CBMostrarCaracter: TCheckBox;
    Panel2: TPanel;
    BtOK: TBitBtn;
    BtCancelar: TBitBtn;
    CBBHabilitarSSL: TCheckBox;
    LBLStartTLS: TLabel;
    procedure BtCancelarClick(Sender: TObject);
    procedure CBMostrarCaracterClick(Sender: TObject);
    procedure CBAutenticacaoClick(Sender: TObject);
    procedure BtOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CBBHabilitarSSLClick(Sender: TObject);
  private
  { Private declarations }
    FSenha: String;
    FAutenticado: Boolean;
    FAtivarSSL: Boolean;
    FServidor: String;
    FPorta: Integer;
    FUsuario: String;
    FRemetente: String;
    FTipoAutenticacao: TIdSMTPAuthenticationType;
  public
    { Public declarations }
    property Servidor    : String read FServidor write FServidor;
    property Usuario     : String read FUsuario write FUsuario;
    property Senha       : String read FSenha write FSenha;
    property Porta       : Integer read FPorta write FPorta;
    property Autenticado : Boolean read FAutenticado write FAutenticado;
    property AtivarSSL   : Boolean read FAtivarSSL write FAtivarSSL;
    property Remetente   : String read FRemetente write FRemetente;
    property TipoAutenticacao: TIdSMTPAuthenticationType read FTipoAutenticacao write FTipoAutenticacao;
  end;

var
  ViewConfiguracaoEmail: TViewConfiguracaoEmail;

implementation


{$R *.dfm}

procedure TViewConfiguracaoEmail.BtCancelarClick(Sender: TObject);
begin
    Close;
end;

procedure TViewConfiguracaoEmail.BtOKClick(Sender: TObject);
begin
    FServidor    := EdtServidor.Text;
    FRemetente   := EdtRemetente.Text;
    FSenha       := MskSenha.Text;
    FAutenticado := CBAutenticacao.Checked;
    FAtivarSSL   := CBBHabilitarSSL.Checked;
    FPorta       := StrToIntDef(EdtPorta.Text, 0);
    FUsuario     := EdtUsuario.Text;

    Close;
end;

procedure TViewConfiguracaoEmail.CBAutenticacaoClick(Sender: TObject);
begin
      if CBAutenticacao.Checked then
      begin
         FTipoAutenticacao := satDefault;
         EdtUsuario.Enabled := True;
         EdtUsuario.Color := clWindow;
         MskSenha.Enabled := True;
         MskSenha.Color := clWindow;
      end
      else
      begin
         FTipoAutenticacao := satNone;
         EdtUsuario.Enabled := False;
         EdtUsuario.Color := clInactiveCaption;
         MskSenha.Enabled := False;
         MskSenha.Color := clInactiveCaption;
      end;
end;

procedure TViewConfiguracaoEmail.CBBHabilitarSSLClick(Sender: TObject);
begin
   LBLStartTLS.Visible := CBBHabilitarSSL.Checked;
end;

procedure TViewConfiguracaoEmail.CBMostrarCaracterClick(Sender: TObject);
begin
   if CBMostrarCaracter.Checked then
      MskSenha.PasswordChar := #0
   else
      MskSenha.PasswordChar := '*';
end;

procedure TViewConfiguracaoEmail.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

end.
