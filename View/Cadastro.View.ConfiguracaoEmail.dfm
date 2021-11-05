object ViewConfiguracaoEmail: TViewConfiguracaoEmail
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configura'#231#227'o do envio de Email'
  ClientHeight = 295
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 487
    Height = 253
    Align = alClient
    BevelOuter = bvNone
    BevelWidth = 2
    BorderStyle = bsSingle
    TabOrder = 0
    ExplicitWidth = 413
    object LbServidor: TLabel
      Left = 14
      Top = 28
      Width = 115
      Height = 19
      Caption = 'Servidor SMTP:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LbPorta: TLabel
      Left = 85
      Top = 64
      Width = 44
      Height = 19
      Caption = 'Porta:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LbUsuario: TLabel
      Left = 68
      Top = 101
      Width = 61
      Height = 19
      Caption = 'Usu'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LbSenha: TLabel
      Left = 77
      Top = 141
      Width = 52
      Height = 19
      Caption = 'Senha:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LbRemetente: TLabel
      Left = 47
      Top = 199
      Width = 82
      Height = 19
      Caption = 'Remetente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LBLStartTLS: TLabel
      Left = 272
      Top = 168
      Width = 152
      Height = 21
      Caption = 'STARTTLS (Ativo)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object EdtServidor: TEdit
      Left = 140
      Top = 25
      Width = 325
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object EdtPorta: TEdit
      Left = 140
      Top = 61
      Width = 46
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 1
      Text = '587'
    end
    object EdtUsuario: TEdit
      Left = 140
      Top = 98
      Width = 325
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object EdtRemetente: TEdit
      Left = 140
      Top = 196
      Width = 325
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object MskSenha: TMaskEdit
      Left = 140
      Top = 134
      Width = 153
      Height = 29
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 4
      Text = ''
    end
    object CBAutenticacao: TCheckBox
      Left = 193
      Top = 68
      Width = 208
      Height = 17
      Caption = 'Habilitar Autentica'#231#227'o'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      OnClick = CBAutenticacaoClick
    end
    object CBMostrarCaracter: TCheckBox
      Left = 300
      Top = 142
      Width = 175
      Height = 17
      Caption = 'Mostrar Caracteres'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = CBMostrarCaracterClick
    end
    object CBBHabilitarSSL: TCheckBox
      Left = 140
      Top = 169
      Width = 126
      Height = 17
      Caption = 'Habilitar SSL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = CBBHabilitarSSLClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 253
    Width = 487
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    BevelWidth = 2
    BorderStyle = bsSingle
    TabOrder = 1
    ExplicitWidth = 413
    DesignSize = (
      483
      38)
    object BtOK: TBitBtn
      Left = 289
      Top = 8
      Width = 80
      Height = 27
      Cursor = crHandPoint
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      Spacing = 5
      TabOrder = 0
      OnClick = BtOKClick
      ExplicitLeft = 215
    end
    object BtCancelar: TBitBtn
      Left = 375
      Top = 8
      Width = 106
      Height = 27
      Cursor = crHandPoint
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      Spacing = 5
      TabOrder = 1
      OnClick = BtCancelarClick
      ExplicitLeft = 301
    end
  end
end
