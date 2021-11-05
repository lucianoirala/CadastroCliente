program Cadastro;

uses
  Vcl.Forms,
  Cadastro.View.Principal in '..\View\Cadastro.View.Principal.pas' {ViewPrincipal},
  Cadastro.Model.Interfaces in '..\Model\Cadastro.Model.Interfaces.pas',
  Cadastro.Controller.CEP in '..\Controller\Cadastro.Controller.CEP.pas',
  Cadastro.Model.CEP in '..\Model\Cadastro.Model.CEP.pas',
  Cadastro.Controller.Cliente in '..\Controller\Cadastro.Controller.Cliente.pas',
  Cadastro.Model.Cliente in '..\Model\Cadastro.Model.Cliente.pas',
  Cadastro.Model.Email in '..\Model\Cadastro.Model.Email.pas',
  Cadastro.Controller.Email in '..\Controller\Cadastro.Controller.Email.pas',
  Cadastro.View.ConfiguracaoEmail in '..\View\Cadastro.View.ConfiguracaoEmail.pas' {ViewConfiguracaoEmail},
  Cadastro.Model.XML in '..\Model\Cadastro.Model.XML.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
