unit Delphi.ORM.Database.Connection.ZeosLib;

interface

uses Delphi.ORM.Database.Connection, ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset, Data.DB;

type
  TDatabaseCursorZeosLib = class(TInterfacedObject, IDatabaseCursor)
  private
    FQuery: TZQuery;

    function GetFieldValue(const FieldIndex: Integer): Variant;
    function GetSQL: String;
    function Next: Boolean;
    function ParamsByName(Name: String): TParam;

    procedure Execute;
    procedure SetSQL(Value: String);
  public
    constructor Create(const Connection: TZConnection; const SQL: String);

    destructor Destroy; override;
  end;

  TDatabaseTransactionZeosLib = class(TInterfacedObject, IDatabaseTransaction)
  private
    FConnection: TUniConnection;

    procedure Commit;
    procedure Rollback;
  public
    constructor Create(const Connection: TZConnection);
  end;

  TDatabaseConnectionZeosLib = class(TInterfacedObject, IDatabaseConnection)
  private
    FConnection: TZConnection;

    procedure ExecuteInsert(const Cursor: IDatabaseCursor; const OutputFields: TArray<String>);
    function OpenCursor(const SQL: String): IDatabaseCursor;
    function StartTransaction: IDatabaseTransaction;

    procedure ExecuteDirect(const SQL: String);
  public
    constructor Create;

    destructor Destroy; override;

    property Connection: TZConnection read FConnection;
  end;

implementation

uses System.SysUtils, System.Variants;

{ TDatabaseConnectionZeosLib }

constructor TDatabaseConnectionZeosLib.Create;
begin
  inherited;

  FConnection := TZConnection.Create(nil);
end;

destructor TDatabaseConnectionZeosLib.Destroy;
begin
  FConnection.Free;

  inherited;
end;

procedure TDatabaseConnectionZeosLib.ExecuteDirect(const SQL: String);
begin
  FConnection.ExecuteDirect(SQL);
end;

procedure TDatabaseConnectionZeosLib.ExecuteInsert(const Cursor: IDatabaseCursor; const OutputFields: TArray<String>);
begin
  var OutputSQL := EmptyStr;

  for var Field in OutputFields do
  begin
    if not OutputSQL.IsEmpty then
      OutputSQL := OutputSQL + ',';

    OutputSQL := OutputSQL + Format('Inserted.%s', [Field]);
  end;

  if OutputSQL.IsEmpty then
    Cursor.Execute
  else
    Cursor.SQL := Cursor.SQL.Replace(')values(', Format(')output %s values(', [OutputSQL]));
end;

function TDatabaseConnectionZeosLib.OpenCursor(const SQL: String): IDatabaseCursor;
begin
  Result := TDatabaseCursorZeosLib.Create(Connection, SQL);
end;

function TDatabaseConnectionZeosLib.StartTransaction: IDatabaseTransaction;
begin
  Result := TDatabaseTransactionZeosLib.Create(Connection);
end;

{ TDatabaseCursorZeosLib }

constructor TDatabaseCursorZeosLib.Create(const Connection: TZConnection; const SQL: String);
begin
  inherited Create;

  FQuery := TZQuery.Create(nil);
  FQuery.Connection := Connection;
  FQuery.SQL.Text := SQL;
end;

destructor TDatabaseCursorZeosLib.Destroy;
begin
  FQuery.Free;

  inherited;
end;

procedure TDatabaseCursorZeosLib.Execute;
begin
  FQuery.Execute;
end;

function TDatabaseCursorZeosLib.GetFieldValue(const FieldIndex: Integer): Variant;
begin
  Result := FQuery.Fields[FieldIndex].Value;
end;

function TDatabaseCursorZeosLib.GetSQL: String;
begin
  Result := FQuery.SQL.Text;
end;

function TDatabaseCursorZeosLib.Next: Boolean;
begin
  if FQuery.Active then
    FQuery.Next
  else
    FQuery.Open;

  Result := not FQuery.Eof;
end;

function TDatabaseCursorZeosLib.ParamsByName(Name: String): TParam;
begin
  Result := FQuery.Params.AddParameter;
  Result.Name := Name;
end;

procedure TDatabaseCursorZeosLib.SetSQL(Value: String);
begin
  FQuery.SQL.Text := Value;
end;

{ TDatabaseTransactionZeosLib }

procedure TDatabaseTransactionZeosLib.Commit;
begin

end;

constructor TDatabaseTransactionZeosLib.Create(const Connection: TZConnection);
begin

end;

procedure TDatabaseTransactionZeosLib.Rollback;
begin

end;

end.
