unit Delphi.ORM.Database.Connection.Unidac;

interface

uses System.SysUtils, System.SyncObjs, Delphi.ORM.Database.Connection, Uni, Data.DB;

type
  TDatabaseConnectionUnidac = class;

  TDatabaseCursorUnidac = class(TInterfacedObject, IDatabaseCursor)
  private
    FConnection: TDatabaseConnectionUnidac;
    FQuery: TUniQuery;

    function GetFieldValue(const FieldIndex: Integer): Variant;
    function GetSQL: String;
    function Next: Boolean;
    function ParamsByName(Name: String): TParam;

    procedure Execute;
    procedure SetSQL(Value: String);
  public
    constructor Create(const Connection: TDatabaseConnectionUnidac; const SQL: String);

    destructor Destroy; override;
  end;

  TDatabaseTransactionUnidac = class(TInterfacedObject, IDatabaseTransaction)
  private
    FConnection: TDatabaseConnectionUnidac;

    procedure Commit;
    procedure Rollback;
  public
    constructor Create(const Connection: TDatabaseConnectionUnidac);

    destructor Destroy; override;
  end;

  TDatabaseConnectionUnidac = class(TInterfacedObject, IDatabaseConnection)
  private
    FConnection: TUniConnection;
    FReadWriteControl: IReadWriteSync;

    function OpenCursor(const SQL: String): IDatabaseCursor;
    function StartTransaction: IDatabaseTransaction;

    procedure ExecuteDirect(const SQL: String);
  public
    constructor Create;

    destructor Destroy; override;

    property Connection: TUniConnection read FConnection;
  end;

implementation

uses System.Variants, Winapi.ActiveX;

{ TDatabaseCursorUnidac }

constructor TDatabaseCursorUnidac.Create(const Connection: TDatabaseConnectionUnidac; const SQL: String);
begin
  inherited Create;

  FConnection := Connection;
  FQuery := TUniQuery.Create(nil);
  FQuery.Connection := FConnection.Connection;
  FQuery.Options.ReturnParams := True;
  FQuery.ParamCheck := False;
  FQuery.SQL.Text := SQL;
  FQuery.FetchRows := 65000;
  FQuery.UniDirectional := True;
end;

destructor TDatabaseCursorUnidac.Destroy;
begin
  try
    FQuery.Free;
  finally
    FConnection.FReadWriteControl.EndWrite;
  end;

  inherited;
end;

procedure TDatabaseCursorUnidac.Execute;
begin
  FQuery.Execute;
end;

function TDatabaseCursorUnidac.GetFieldValue(const FieldIndex: Integer): Variant;
begin
  Result := FQuery.Fields[FieldIndex].AsVariant;
end;

function TDatabaseCursorUnidac.GetSQL: String;
begin
  Result := FQuery.SQL.Text;
end;

function TDatabaseCursorUnidac.Next: Boolean;
begin
  if FQuery.Active then
    FQuery.Next
  else
  begin
    FConnection.FReadWriteControl.BeginWrite;

    FQuery.Open;
  end;

  Result := not FQuery.Eof;
end;

function TDatabaseCursorUnidac.ParamsByName(Name: String): TParam;
begin
  Result := FQuery.Params.FindParam(Name);

  if not Assigned(Result) then
    Result := FQuery.Params.AddParameter;

  Result.Name := Name;
end;

procedure TDatabaseCursorUnidac.SetSQL(Value: String);
begin
  FQuery.SQL.Text := Value;
end;

{ TDatabaseConnectionUnidac }

constructor TDatabaseConnectionUnidac.Create;
begin
  inherited;

  CoInitialize(nil);

  FConnection := TUniConnection.Create(nil);
  FConnection.Options.DisconnectedMode := True;
  FConnection.Pooling := True;
  FConnection.PoolingOptions.MaxPoolSize := 500;
  FReadWriteControl := TMultiReadExclusiveWriteSynchronizer.Create;
end;

destructor TDatabaseConnectionUnidac.Destroy;
begin
  FConnection.Free;

  inherited;
end;

procedure TDatabaseConnectionUnidac.ExecuteDirect(const SQL: String);
begin
  FReadWriteControl.BeginWrite;

  try
    FConnection.ExecSQL(SQL);
  finally
    FReadWriteControl.EndWrite;
  end;
end;

function TDatabaseConnectionUnidac.OpenCursor(const SQL: String): IDatabaseCursor;
begin
  Result := TDatabaseCursorUnidac.Create(Self, SQL);
end;

function TDatabaseConnectionUnidac.StartTransaction: IDatabaseTransaction;
begin
  Result := TDatabaseTransactionUnidac.Create(Self);
end;

{ TDatabaseTransactionUnidac }

procedure TDatabaseTransactionUnidac.Commit;
begin
  FConnection.FConnection.Commit;
end;

constructor TDatabaseTransactionUnidac.Create(const Connection: TDatabaseConnectionUnidac);
begin
  inherited Create;

  FConnection := Connection;

  FConnection.FReadWriteControl.BeginWrite;

  FConnection.FConnection.StartTransaction;
end;

destructor TDatabaseTransactionUnidac.Destroy;
begin
  FConnection.FReadWriteControl.EndWrite;

  inherited;
end;

procedure TDatabaseTransactionUnidac.Rollback;
begin
  FConnection.FConnection.Rollback;
end;

end.

