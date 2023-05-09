unit Delphi.ORM.Database.Connection.Firedac;

interface

uses Delphi.ORM.Database.Connection, Firedac.Comp.Client, Data.DB;

type
  TDatabaseCursorFiredac = class(TInterfacedObject, IDatabaseCursor)
  private
    FQuery: TFDQuery;

    function GetFieldValue(const FieldIndex: Integer): Variant;
    function GetSQL: String;
    function Next: Boolean;
    function ParamsByName(Name: String): TParam;

    procedure Execute;
    procedure SetSQL(Value: String);
  public
    constructor Create(const Connection: TFDConnection; const SQL: String);

    destructor Destroy; override;
  end;

  TDatabaseTransactionFiredac = class(TInterfacedObject, IDatabaseTransaction)
  private
    FConnection: TFDConnection;

    procedure Commit;
    procedure Rollback;
  public
    constructor Create(const Connection: TFDConnection);
  end;

  TDatabaseConnectionFiredac = class(TInterfacedObject, IDatabaseConnection)
  private
    FConnection: TFDConnection;

    procedure ExecuteInsert(const Cursor: IDatabaseCursor; const OutputFields: TArray<String>);
    function OpenCursor(const SQL: String): IDatabaseCursor;
    function StartTransaction: IDatabaseTransaction;

    procedure ExecuteDirect(const SQL: String);
  public
    constructor Create;

    destructor Destroy; override;

    property Connection: TFDConnection read FConnection;
  end;

implementation

uses System.SysUtils, System.Variants, Winapi.ActiveX, Firedac.Stan.Def, Firedac.Stan.Option, Firedac.DApt, Firedac.Stan.Async;

{ TDatabaseCursorFiredac }

constructor TDatabaseCursorFiredac.Create(const Connection: TFDConnection; const SQL: String);
begin
  inherited Create;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := Connection;
  FQuery.SQL.Text := SQL;
end;

destructor TDatabaseCursorFiredac.Destroy;
begin
  FQuery.Free;

  inherited;
end;

procedure TDatabaseCursorFiredac.Execute;
begin
  FQuery.Execute;
end;

function TDatabaseCursorFiredac.GetFieldValue(const FieldIndex: Integer): Variant;
begin
  var Field := FQuery.Fields[FieldIndex];

  if Field is TSQLTimeStampField then
    Result := Field.AsDateTime
  else
    Result := Field.AsVariant;
end;

function TDatabaseCursorFiredac.GetSQL: String;
begin
  Result := FQuery.SQL.Text;
end;

function TDatabaseCursorFiredac.Next: Boolean;
begin
  if FQuery.Active then
    FQuery.Next
  else
    FQuery.Open;
  Result := not FQuery.Eof;
end;

function TDatabaseCursorFiredac.ParamsByName(Name: String): TParam;
begin
  Result := TParam(FQuery.Params.Add);
  Result.Name := Name;
end;

procedure TDatabaseCursorFiredac.SetSQL(Value: String);
begin
  FQuery.SQL.Text := Value;
end;

{ TDatabaseConnectionFiredac }

constructor TDatabaseConnectionFiredac.Create;
begin
  inherited;

  CoInitialize(nil);

  FConnection := TFDConnection.Create(nil);
  FConnection.FetchOptions.CursorKind := ckForwardOnly;
  FConnection.FetchOptions.Items := [];
  FConnection.FetchOptions.Mode := fmOnDemand;
  FConnection.FetchOptions.RowsetSize := 1000;
  FConnection.FetchOptions.Unidirectional := True;
  FConnection.ResourceOptions.SilentMode := True;
end;

destructor TDatabaseConnectionFiredac.Destroy;
begin
  FConnection.Free;

  inherited;
end;

procedure TDatabaseConnectionFiredac.ExecuteDirect(const SQL: String);
begin
  FConnection.ExecSQL(SQL);
end;

procedure TDatabaseConnectionFiredac.ExecuteInsert(const Cursor: IDatabaseCursor; const OutputFields: TArray<String>);
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

function TDatabaseConnectionFiredac.OpenCursor(const SQL: String): IDatabaseCursor;
begin
  Result := TDatabaseCursorFiredac.Create(Connection, SQL);
end;

function TDatabaseConnectionFiredac.StartTransaction: IDatabaseTransaction;
begin
  Result := TDatabaseTransactionFiredac.Create(Connection);
end;

{ TDatabaseTransactionFiredac }

procedure TDatabaseTransactionFiredac.Commit;
begin
  FConnection.Commit;
end;

constructor TDatabaseTransactionFiredac.Create(const Connection: TFDConnection);
begin
  inherited Create;

  FConnection := Connection;

  FConnection.StartTransaction;
end;

procedure TDatabaseTransactionFiredac.Rollback;
begin
  FConnection.Rollback;
end;

end.
