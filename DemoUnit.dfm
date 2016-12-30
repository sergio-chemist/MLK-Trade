object frmMSSQLDemo: TfrmMSSQLDemo
  Left = 579
  Top = 204
  Width = 434
  Height = 416
  Caption = 'MS SQL Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 418
    Height = 177
    Align = alTop
    DataSource = DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Title.Caption = 'Num'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Title.Caption = 'First Name'
        Width = 100
        Visible = True
      end>
  end
  object edRes: TEdit
    Left = 8
    Top = 288
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Result: 0'
  end
  object edQuery: TEdit
    Left = 8
    Top = 320
    Width = 401
    Height = 21
    TabOrder = 2
    Text = 'edQuery'
  end
  object SQLConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;User ID=Test;Initial Catalog=TestBase;Data Source=PROGC' +
      '01\ZSERGIO;Use Procedure for Prepare=1;Auto Translate=True;Packe' +
      't Size=4096;Workstation ID=HOME-PC;Use Encryption for Data=False' +
      ';Tag with column collation when possible=False'
    LoginPrompt = False
    Mode = cmShareDenyWrite
    Provider = 'SQLOLEDB.1'
    Left = 96
    Top = 48
  end
  object SQLQuery: TADOQuery
    Connection = SQLConnection
    CursorType = ctStatic
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM MyTable order by [name] desc;')
    Left = 136
    Top = 72
  end
  object ADOTable: TADOTable
    Connection = SQLConnection
    CursorType = ctStatic
    TableName = 'MyTable'
    Left = 224
    Top = 48
  end
  object DataSource: TDataSource
    DataSet = SQLQuery
    Left = 48
    Top = 96
  end
  object MainMenu1: TMainMenu
    Left = 152
    Top = 144
    object File1: TMenuItem
      Caption = 'File'
      object mnuExit: TMenuItem
        Caption = 'Exit'
        OnClick = mnuExitClick
      end
    end
    object SQL1: TMenuItem
      Caption = 'SQL'
      object ToggleFirstTable1: TMenuItem
        Caption = 'Toggle First Table'
        OnClick = ToggleFirstTable1Click
      end
      object ToggleSecondTable1: TMenuItem
        Caption = 'Toggle Second Table'
        OnClick = ToggleSecondTable1Click
      end
    end
  end
end
