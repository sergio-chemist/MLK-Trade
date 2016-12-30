unit DemoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, Menus, StdCtrls;

type
  TfrmMSSQLDemo = class(TForm)
    SQLConnection: TADOConnection;
    SQLQuery: TADOQuery;
    ADOTable: TADOTable;
    DataSource: TDataSource;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    mnuExit: TMenuItem;
    SQL1: TMenuItem;
    ToggleFirstTable1: TMenuItem;
    ToggleSecondTable1: TMenuItem;
    edRes: TEdit;
    edQuery: TEdit;
    procedure mnuExitClick(Sender: TObject);
    procedure ToggleFirstTable1Click(Sender: TObject);
    procedure ToggleSecondTable1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    Descending: Boolean;
    LastIndex: Integer;
  public
    { Public declarations }
  end;

var
  frmMSSQLDemo: TfrmMSSQLDemo;

implementation

{$R *.dfm}

function SortByHeaderTitle(
          Grid: TDBGrid; MainSQL, ColTitle: String;
          Descending: Boolean = false;
          PStr: PString = nil): Integer;
const
  DirArray: array[Boolean] of ShortString = (' asc', ' desc');
var DS: TDataSet; Str: String;
    SQL: TStrings;
begin
  Result:= 0;
     if (Grid<>nil) and (Grid.DataSource<>nil) then
     begin
       DS:= Grid.DataSource.DataSet;
       if (DS<>nil) then
          begin
            Str:= Format('%s order by [%s] %s',
            [MainSQL, ColTitle, DirArray[Descending]]);
            if (PStr<>nil) then PStr^:= Str;
            SQL:= TADOQuery(DS).SQL;
            SQL.SetText(Pointer(Str));
            {
            SQL.BeginUpdate;
            SQL.Clear;
            SQL.Add(Str);
            SQL.EndUpdate;
            }
            //Result:=TADOQuery(DS).ExecSQL;
          end;
     end;
end;

procedure TfrmMSSQLDemo.mnuExitClick(Sender: TObject);
begin
  ADOTable.Active:= false;
  SQLQuery.Active:= false;
  Close;
end;

procedure TfrmMSSQLDemo.ToggleFirstTable1Click(Sender: TObject);
begin
  if (DataSource.DataSet = SQLQuery) and
     SQLQuery.Active then
     begin
     SQLQuery.Active := false;
     exit;
     end;
  DataSource.DataSet:= ADOTable;
  ADOTable.Active := not ADOTable.Active;
end;

procedure TfrmMSSQLDemo.ToggleSecondTable1Click(Sender: TObject);
begin
  if (DataSource.DataSet = ADOTable) and
     ADOTable.Active then
     begin
     ADOTable.Active := false;
     exit;
     end;
  DataSource.DataSet:= SQLQuery;
  SQLQuery.Active := not SQLQuery.Active;
end;

procedure TfrmMSSQLDemo.DBGrid1TitleClick(Column: TColumn);
var Index, Res: Integer; S: String;
begin
//  MessageDlg( Column.FieldName + ' as ' + Column.Title.Caption,
//              mtInformation, [mbOK], 0);
  Index:= Column.Field.FieldNo;
  if (Index<>LastIndex) then Descending:= false;
  SQLQuery.Active:= false;
  Res:= SortByHeaderTitle(
  DBGrid1, 'SELECT MyTable.id, MyTable.name FROM MyTable', Column.FieldName,
  Descending, @S);
  edRes.Text:= 'Result: ' + IntToStr(Res);
  edQuery.Text:= S;
  SQLQuery.Active:= true;
  Descending:= not Descending;
  LastIndex:= Index;
end;

end.
