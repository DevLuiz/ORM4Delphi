﻿unit Delphi.ORM.Database.Metadata;

interface

uses System.Generics.Collections, System.SysUtils, Delphi.ORM.Database.Connection, Delphi.ORM.Mapper, Delphi.ORM.Attributes;

type
  TDatabaseCheckConstraint = class;
  TDatabaseDefaultConstraint = class;
  TDatabaseField = class;
  TDatabaseForeignKey = class;
  TDatabaseIndex = class;
  TDatabaseSchema = class;
  TDatabaseSequence = class;
  TDatabaseTable = class;

  IMetadataManipulator = interface
    ['{7ED4F3DE-1C13-4CF3-AE3C-B51386EA271F}']
    function GetAllRecords(const Table: TTable): TArray<TObject>;
    function GetAutoGeneratedValue(const DefaultConstraint: TDefaultConstraint): String;
    function GetDefaultConstraintName(const Field: TField): String;

    procedure CreateDefaultConstraint(const Field: TField);
    procedure CreateField(const Field: TField);
    procedure CreateForeignKey(const ForeignKey: TForeignKey);
    procedure CreateIndex(const Index: TIndex);
    procedure CreateSequence(const Sequence: TSequence);
    procedure CreateTable(const Table: TTable);
    procedure CreateTempField(const Field: TField);
    procedure DropDefaultConstraint(const Field: TDatabaseField);
    procedure DropField(const Field: TDatabaseField);
    procedure DropForeignKey(const ForeignKey: TDatabaseForeignKey);
    procedure DropIndex(const Index: TDatabaseIndex);
    procedure DropSequence(const Sequence: TDatabaseSequence);
    procedure DropTable(const Table: TDatabaseTable);
    procedure InsertRecord(const Value: TObject);
    procedure LoadSchema(const Schema: TDatabaseSchema);
    procedure RenameField(const Current, Destiny: TField);
    procedure UpdateField(const SourceField, DestinyField: TField);
    procedure UpdateRecord(const Value: TObject);
  end;

  TDatabaseSchema = class
  private
    FSequences: TList<TDatabaseSequence>;
    FTables: TList<TDatabaseTable>;

    function GetTable(const Name: String): TDatabaseTable;
    function GetSequence(const Name: String): TDatabaseSequence;
  public
    constructor Create;

    destructor Destroy; override;

    property Sequence[const Name: String]: TDatabaseSequence read GetSequence;
    property Sequences: TList<TDatabaseSequence> read FSequences;
    property Table[const Name: String]: TDatabaseTable read GetTable;
    property Tables: TList<TDatabaseTable> read FTables;
  end;

  TDatabaseNamedObject = class
  private
    FName: String;
  public
    constructor Create(const Name: String);

    class function FindObject<T: TDatabaseNamedObject>(const List: TList<T>; const Name: String): T;

    property Name: String read FName write FName;
  end;

  TDatabaseTableObject = class(TDatabaseNamedObject)
  private
    FTable: TDatabaseTable;
  public
    constructor Create(const Table: TDatabaseTable; const Name: String);

    property Table: TDatabaseTable read FTable;
  end;

  TDatabaseTable = class(TDatabaseNamedObject)
  private
    FFields: TList<TDatabaseField>;
    FForeignKeys: TList<TDatabaseForeignKey>;
    FIndexes: TList<TDatabaseIndex>;
    FSchema: TDatabaseSchema;

    function GetField(const Name: String): TDatabaseField;
    function GetForeignKey(const Name: String): TDatabaseForeignKey;
    function GetIndex(const Name: String): TDatabaseIndex;
  public
    constructor Create(const Schema: TDatabaseSchema; const Name: String);

    destructor Destroy; override;

    property Field[const Name: String]: TDatabaseField read GetField;
    property Fields: TList<TDatabaseField> read FFields;
    property ForeignKey[const Name: String]: TDatabaseForeignKey read GetForeignKey;
    property ForeignKeys: TList<TDatabaseForeignKey> read FForeignKeys;
    property Index[const Name: String]: TDatabaseIndex read GetIndex;
    property Indexes: TList<TDatabaseIndex> read FIndexes;
    property Schema: TDatabaseSchema read FSchema write FSchema;
  end;

  TDatabaseField = class(TDatabaseTableObject)
  private
    FCheck: TDatabaseCheckConstraint;
    FCollation: String;
    FDefaultConstraint: TDatabaseDefaultConstraint;
    FFieldType: TTypeKind;
    FRequired: Boolean;
    FScale: Word;
    FSize: Word;
    FSpecialType: TDatabaseSpecialType;
  public
    constructor Create(const Table: TDatabaseTable; const Name: String);

    destructor Destroy; override;

    property Check: TDatabaseCheckConstraint read FCheck write FCheck;
    property Collation: String read FCollation write FCollation;
    property DefaultConstraint: TDatabaseDefaultConstraint read FDefaultConstraint write FDefaultConstraint;
    property FieldType: TTypeKind read FFieldType write FFieldType;
    property Required: Boolean read FRequired write FRequired;
    property Scale: Word read FScale write FScale;
    property Size: Word read FSize write FSize;
    property SpecialType: TDatabaseSpecialType read FSpecialType write FSpecialType;
  end;

  TDatabaseIndex = class(TDatabaseTableObject)
  private
    FFields: TArray<TDatabaseField>;
    FPrimaryKey: Boolean;
    FUnique: Boolean;
  public
    constructor Create(const Table: TDatabaseTable; const Name: String);

    property Fields: TArray<TDatabaseField> read FFields write FFields;
    property PrimaryKey: Boolean read FPrimaryKey write FPrimaryKey;
    property Unique: Boolean read FUnique write FUnique;
  end;

  TDatabaseForeignKey = class(TDatabaseTableObject)
  private
    FFields: TArray<TDatabaseField>;
    FFieldsReference: TArray<TDatabaseField>;
    FReferenceTable: TDatabaseTable;
  public
    constructor Create(const ParentTable: TDatabaseTable; const Name: String; const ReferenceTable: TDatabaseTable);

    property Fields: TArray<TDatabaseField> read FFields write FFields;
    property FieldsReference: TArray<TDatabaseField> read FFieldsReference write FFieldsReference;
    property ReferenceTable: TDatabaseTable read FReferenceTable write FReferenceTable;
  end;

  TDatabaseDefaultConstraint = class(TDatabaseNamedObject)
  private
    FValue: String;
  public
    constructor Create(const Field: TDatabaseField; const Name, Value: String);

    property Value: String read FValue write FValue;
  end;

  TDatabaseCheckConstraint = class(TDatabaseNamedObject)
  private
    FCheck: String;
  public
    constructor Create(const Field: TDatabaseField; const Name, Check: String);

    property Check: String read FCheck write FCheck;
  end;

  TDatabaseSequence = class(TDatabaseNamedObject)
  end;

  TDatabaseMetadataUpdate = class
  private
    FMapper: TMapper;
    FMetadataManipulator: IMetadataManipulator;

    function CheckSameFields(const Fields: TArray<TField>; const DatabaseFields: TArray<TDatabaseField>): Boolean;
    function FieldInTheList(const DatabaseField: TDatabaseField; const DatabaseFields: TArray<TDatabaseField>): Boolean;
    function GetMapper: TMapper; inline;

    procedure CheckChangingTheList<T>(const List: TList<T>; const Func: TFunc<T, Boolean>);
    procedure CreateField(const Field: TField);
    procedure DropField(const DatabaseField: TDatabaseField);
    procedure DropForeignKey(const DatabaseForeignKey: TDatabaseForeignKey);
    procedure DropIndex(const DatabaseIndex: TDatabaseIndex);
    procedure DropTable(const DatabaseTable: TDatabaseTable);
    procedure RecreateField(const Field: TField; const DatabaseField: TDatabaseField);
  public
    constructor Create(const MetadataManipulator: IMetadataManipulator);

    procedure UpdateDatabase;

    property Mapper: TMapper read GetMapper write FMapper;
  end;

implementation

uses System.TypInfo, System.Rtti, System.Generics.Defaults;

{ TDatabaseNamedObject }

constructor TDatabaseNamedObject.Create(const Name: String);
begin
  inherited Create;

  FName := Name;
end;

class function TDatabaseNamedObject.FindObject<T>(const List: TList<T>; const Name: String): T;
begin
  Result := nil;

  for var AObject in List do
    if AnsiCompareText(AObject.Name, Name) = 0 then
      Exit(AObject);
end;

{ TDatabaseTableObject }

constructor TDatabaseTableObject.Create(const Table: TDatabaseTable; const Name: String);
begin
  inherited Create(Name);

  FTable := Table;
end;

{ TDatabaseForeignKey }

constructor TDatabaseForeignKey.Create(const ParentTable: TDatabaseTable; const Name: String; const ReferenceTable: TDatabaseTable);
begin
  inherited Create(ParentTable, Name);

  FReferenceTable := ReferenceTable;

  FTable.FForeignKeys.Add(Self);
end;

{ TDatabaseField }

constructor TDatabaseField.Create(const Table: TDatabaseTable; const Name: String);
begin
  inherited;

  FTable.FFields.Add(Self);
end;

destructor TDatabaseField.Destroy;
begin
  FDefaultConstraint.Free;

  FCheck.Free;

  inherited;
end;

{ TDatabaseIndex }

constructor TDatabaseIndex.Create(const Table: TDatabaseTable; const Name: String);
begin
  inherited;

  FTable.FIndexes.Add(Self);
end;

{ TDatabaseTable }

constructor TDatabaseTable.Create(const Schema: TDatabaseSchema; const Name: String);
begin
  inherited Create(Name);

  FFields := TObjectList<TDatabaseField>.Create;
  FForeignKeys := TObjectList<TDatabaseForeignKey>.Create;
  FIndexes := TObjectList<TDatabaseIndex>.Create;
  FSchema := Schema;

  Schema.Tables.Add(Self);
end;

destructor TDatabaseTable.Destroy;
begin
  FFields.Free;

  FForeignKeys.Free;

  FIndexes.Free;

  inherited;
end;

function TDatabaseTable.GetField(const Name: String): TDatabaseField;
begin
  Result := TDatabaseNamedObject.FindObject<TDatabaseField>(Fields, Name);
end;

function TDatabaseTable.GetForeignKey(const Name: String): TDatabaseForeignKey;
begin
  Result := TDatabaseNamedObject.FindObject<TDatabaseForeignKey>(ForeignKeys, Name);
end;

function TDatabaseTable.GetIndex(const Name: String): TDatabaseIndex;
begin
  Result := TDatabaseNamedObject.FindObject<TDatabaseIndex>(Indexes, Name);
end;

{ TDatabaseMetadataUpdate }

procedure TDatabaseMetadataUpdate.CheckChangingTheList<T>(const List: TList<T>; const Func: TFunc<T, Boolean>);
begin
  var A := 0;

  while A < List.Count do
    if not Func(List[A]) then
      Inc(A);
end;

function TDatabaseMetadataUpdate.CheckSameFields(const Fields: TArray<TField>; const DatabaseFields: TArray<TDatabaseField>): Boolean;
begin
  Result := Length(Fields) = Length(DatabaseFields);

  if Result then
    for var A := Low(Fields) to High(Fields) do
      if Fields[A].DatabaseName <> DatabaseFields[A].Name then
        Exit(False);
end;

constructor TDatabaseMetadataUpdate.Create(const MetadataManipulator: IMetadataManipulator);
begin
  inherited Create;

  FMetadataManipulator := MetadataManipulator;

  Randomize;
end;

procedure TDatabaseMetadataUpdate.CreateField(const Field: TField);
begin
  FMetadataManipulator.CreateField(Field);
end;

procedure TDatabaseMetadataUpdate.DropField(const DatabaseField: TDatabaseField);
begin
  for var Table in DatabaseField.Table.Schema.Tables do
    CheckChangingTheList<TDatabaseForeignKey>(Table.ForeignKeys,
      function (DatabaseForeignKey: TDatabaseForeignKey): Boolean
      begin
        Result := FieldInTheList(DatabaseField, DatabaseForeignKey.FieldsReference) or FieldInTheList(DatabaseField, DatabaseForeignKey.Fields);

        if Result then
          DropForeignKey(DatabaseForeignKey);
      end);

  CheckChangingTheList<TDatabaseIndex>(DatabaseField.Table.Indexes,
    function (Index: TDatabaseIndex): Boolean
    begin
      Result := FieldInTheList(DatabaseField, Index.Fields);

      if Result then
        DropIndex(Index);
    end);

  if Assigned(DatabaseField.DefaultConstraint) then
    FMetadataManipulator.DropDefaultConstraint(DatabaseField);

  FMetadataManipulator.DropField(DatabaseField);

  DatabaseField.Table.Fields.Remove(DatabaseField);
end;

procedure TDatabaseMetadataUpdate.DropForeignKey(const DatabaseForeignKey: TDatabaseForeignKey);
begin
  FMetadataManipulator.DropForeignKey(DatabaseForeignKey);

  DatabaseForeignKey.Table.ForeignKeys.Remove(DatabaseForeignKey);
end;

procedure TDatabaseMetadataUpdate.DropIndex(const DatabaseIndex: TDatabaseIndex);
begin
  if DatabaseIndex.PrimaryKey then
    for var Table in DatabaseIndex.Table.Schema.Tables do
      CheckChangingTheList<TDatabaseForeignKey>(Table.ForeignKeys,
        function (DatabaseForeignKey: TDatabaseForeignKey): Boolean
        begin
          Result := DatabaseIndex.Table = DatabaseForeignKey.ReferenceTable;

          if Result then
            DropForeignKey(DatabaseForeignKey);
        end);

  FMetadataManipulator.DropIndex(DatabaseIndex);

  DatabaseIndex.Table.Indexes.Remove(DatabaseIndex);
end;

procedure TDatabaseMetadataUpdate.DropTable(const DatabaseTable: TDatabaseTable);
begin
  for var Table in DatabaseTable.Schema.Tables do
    CheckChangingTheList<TDatabaseForeignKey>(Table.ForeignKeys,
      function (DatabaseForeignKey: TDatabaseForeignKey): Boolean
      begin
        Result := (DatabaseTable = DatabaseForeignKey.ReferenceTable) or (DatabaseTable = DatabaseForeignKey.Table);

        if Result then
          DropForeignKey(DatabaseForeignKey);
      end);

  FMetadataManipulator.DropTable(DatabaseTable);
end;

function TDatabaseMetadataUpdate.FieldInTheList(const DatabaseField: TDatabaseField; const DatabaseFields: TArray<TDatabaseField>): Boolean;
begin
  Result := False;

  for var Field in DatabaseFields do
    if Field = DatabaseField then
      Exit(True);
end;

function TDatabaseMetadataUpdate.GetMapper: TMapper;
begin
  if not Assigned(FMapper) then
    FMapper := TMapper.Default;

  Result := FMapper;
end;

procedure TDatabaseMetadataUpdate.RecreateField(const Field: TField; const DatabaseField: TDatabaseField);
begin
  try
    var TempField := TField.Create(Field.Table);
    TempField.DatabaseName := 'TempField' + Trunc(Random * 1000000).ToString;
    TempField.FieldType := Field.FieldType;
    TempField.ForeignKey := Field.ForeignKey;
    TempField.IsForeignKey := Field.IsForeignKey;
    TempField.Name := TempField.DatabaseName;
    TempField.Required := Field.Required;
    TempField.Scale := Field.Scale;
    TempField.Size := Field.Size;
    TempField.SpecialType := Field.SpecialType;

    FMetadataManipulator.CreateTempField(TempField);

    FMetadataManipulator.UpdateField(Field, TempField);

    DropField(DatabaseField);

    FMetadataManipulator.RenameField(TempField, Field);

    TempField.Free;
  except
    on E: Exception do
      raise Exception.CreateFmt('Erro trying to convert the field %s.%s: %s', [Field.Table.DatabaseName, Field.DatabaseName, E.Message]);
  end;
end;

procedure TDatabaseMetadataUpdate.UpdateDatabase;
var
  DatabaseField: TDatabaseField;

  DatabaseForeignKey: TDatabaseForeignKey;

  DatabaseIndex: TDatabaseIndex;

  DatabaseSequence: TDatabaseSequence;

  DatabaseTable: TDatabaseTable;

  ForeignKey: TForeignKey;

  Field: TField;

  Index: TIndex;

  Sequence: TSequence;

  Table: TTable;

  Tables: TDictionary<String, TTable>;

  Schema: TDatabaseSchema;

  function ExistsForeigKey(const DatabaseForeignKey: TDatabaseForeignKey): Boolean;
  begin
    Result := False;

    for var ForeignKey in Tables[DatabaseForeignKey.Table.Name].ForeignKeys do
      if ForeignKey.DatabaseName = DatabaseForeignKey.Name then
        Exit(True);
  end;

  function ExistsIndex(const DatabaseIndex: TDatabaseIndex): Boolean;
  begin
    Result := False;

    for var Index in Tables[DatabaseIndex.Table.Name].Indexes do
      if Index.DatabaseName = DatabaseIndex.Name then
        Exit(True);
  end;

  function ExistsField(const DatabaseField: TDatabaseField): Boolean;
  begin
    Result := False;

    for var Field in Tables[DatabaseField.Table.Name].Fields do
      if Field.DatabaseName = DatabaseField.Name then
        Exit(True);
  end;

  function IsSpecialType: Boolean;
  begin
    Result := Field.SpecialType <> stNotDefined;
  end;

  function FieldSizeChanged: Boolean;
  begin
    Result := (Field.Size <> DatabaseField.Size) and (Field.FieldType.TypeKind in [tkUString, tkFloat]) and not IsSpecialType;
  end;

  function FieldScaleChanged: Boolean;
  begin
    Result := (Field.Scale <> DatabaseField.Scale) and (Field.FieldType.TypeKind = tkFloat) and not IsSpecialType;
  end;

  function FieldSpecialTypeChanged: Boolean;
  begin
    Result := Field.SpecialType <> DatabaseField.SpecialType;
  end;

  function FieldTypeChanged: Boolean;
  begin
    var FieldKind := Field.FieldType.TypeKind;

    Result := FieldKind <> DatabaseField.FieldType;
  end;

  function FieldRequiredChanged: Boolean;
  begin
    Result := Field.Required <> DatabaseField.Required;
  end;

  function FieldDefaultValueChanged: Boolean;
  begin
    Result := Assigned(DatabaseField.DefaultConstraint) xor Assigned(Field.DefaultConstraint) or Assigned(DatabaseField.DefaultConstraint)
      and ((DatabaseField.DefaultConstraint.Name <> FMetadataManipulator.GetDefaultConstraintName(Field))
        or (FMetadataManipulator.GetAutoGeneratedValue(Field.DefaultConstraint).ToLower <> DatabaseField.DefaultConstraint.Value.ToLower));
  end;

  function FieldChanged: Boolean;
  begin
    Result := FieldTypeChanged or FieldSizeChanged or FieldScaleChanged or FieldSpecialTypeChanged or FieldRequiredChanged
  end;

  procedure RecreateIndex(const Index: TIndex; const DatabaseIndex: TDatabaseIndex);
  begin
    if Assigned(DatabaseIndex) then
      DropIndex(DatabaseIndex);

    FMetadataManipulator.CreateIndex(Index);
  end;

  function GetPrimaryKeyDatabaseIndex: TDatabaseIndex;
  begin
    Result := nil;

    for var DatabaseIndex in DatabaseTable.Indexes do
      if DatabaseIndex.PrimaryKey then
        Exit(DatabaseIndex);
  end;

  procedure LoadDatabaseSchema;
  begin
    Schema := TDatabaseSchema.Create;

    FMetadataManipulator.LoadSchema(Schema);
  end;

  procedure CreateTable(const Table: TTable);
  begin
    FMetadataManipulator.CreateTable(Table);

    DatabaseTable := TDatabaseTable.Create(Schema, Table.DatabaseName);
  end;

begin
  Tables := TDictionary<String, TTable>.Create;

  LoadDatabaseSchema;

  for Sequence in Mapper.Sequences do
    if not Assigned(Schema.Sequence[Sequence.Name]) then
      FMetadataManipulator.CreateSequence(Sequence);

  for Table in Mapper.Tables do
  begin
    DatabaseTable := Schema.Table[Table.DatabaseName];

    Tables.Add(Table.DatabaseName, Table);

    if not Assigned(DatabaseTable) then
      CreateTable(Table)
    else
      for Field in Table.Fields do
        if not Field.IsManyValueAssociation then
        begin
          DatabaseField := DatabaseTable.Field[Field.DatabaseName];

          if not Assigned(DatabaseField) then
            CreateField(Field)
          else if FieldChanged then
            RecreateField(Field, DatabaseField)
          else
          begin
            if FieldDefaultValueChanged then
            begin
              if Assigned(DatabaseField.DefaultConstraint) then
                FMetadataManipulator.DropDefaultConstraint(DatabaseField);

              if Assigned(Field.DefaultConstraint) then
                FMetadataManipulator.CreateDefaultConstraint(Field);
            end;

            if Field.DatabaseName <> DatabaseField.Name then
            begin
              DatabaseField.Name := Field.DatabaseName;

              FMetadataManipulator.RenameField(Field, Field);
            end;
          end;
        end;
  end;

  for Table in Mapper.Tables do
    if Table.DefaultRecords.Count > 0 then
    begin
      var RecordFound: Boolean;
      var Records := FMetadataManipulator.GetAllRecords(Table);

      for var DefaultRecord in Table.DefaultRecords do
      begin
        RecordFound := False;

        for var DatabaseRecord in Records do
          RecordFound := RecordFound or (Table.PrimaryKey.GetAsString(DefaultRecord) = Table.PrimaryKey.GetAsString(DatabaseRecord));

        if RecordFound then
          FMetadataManipulator.UpdateRecord(DefaultRecord)
        else
          FMetadataManipulator.InsertRecord(DefaultRecord);
      end;
    end;

  for Table in Mapper.Tables do
  begin
    DatabaseTable := Schema.Table[Table.DatabaseName];

    if Assigned(DatabaseTable) then
      for Index in Table.Indexes do
      begin
        if Index.PrimaryKey then
          DatabaseIndex := GetPrimaryKeyDatabaseIndex
        else
          DatabaseIndex := DatabaseTable.Index[Index.DatabaseName];

        if not Assigned(DatabaseIndex) or not CheckSameFields(Index.Fields, DatabaseIndex.Fields) or (DatabaseIndex.Name <> Index.DatabaseName)
          or (DatabaseIndex.Unique xor Index.Unique) then
          RecreateIndex(Index, DatabaseIndex);
      end;
  end;

  for Table in Mapper.Tables do
  begin
    DatabaseTable := Schema.Table[Table.DatabaseName];

    if Assigned(DatabaseTable) then
      for ForeignKey in Table.ForeignKeys do
      begin
        DatabaseForeignKey := DatabaseTable.ForeignKey[ForeignKey.DatabaseName];

        if not Assigned(DatabaseForeignKey) then
          FMetadataManipulator.CreateForeignKey(ForeignKey)
        else if not CheckSameFields([ForeignKey.Field], DatabaseForeignKey.Fields) then
        begin
          DropForeignKey(DatabaseForeignKey);

          FMetadataManipulator.CreateForeignKey(ForeignKey)
        end;
      end;
  end;

  for DatabaseTable in Schema.Tables do
    if Tables.ContainsKey(DatabaseTable.Name) then
    begin
      for DatabaseForeignKey in DatabaseTable.ForeignKeys do
        if not ExistsForeigKey(DatabaseForeignKey) then
          DropForeignKey(DatabaseForeignKey);

      for DatabaseIndex in DatabaseTable.Indexes do
        if not ExistsIndex(DatabaseIndex) then
          DropIndex(DatabaseIndex);

      for DatabaseField in DatabaseTable.Fields do
        if not ExistsField(DatabaseField) then
          DropField(DatabaseField);
    end
    else
      DropTable(DatabaseTable);

  for DatabaseSequence in Schema.Sequences do
    if not Assigned(Mapper.FindSequence(DatabaseSequence.Name)) then
      FMetadataManipulator.DropSequence(DatabaseSequence);

  Schema.Free;

  Tables.Free;
end;

{ TDatabaseSchema }

constructor TDatabaseSchema.Create;
begin
  inherited;

  FSequences := TObjectList<TDatabaseSequence>.Create;
  FTables := TObjectList<TDatabaseTable>.Create;
end;

destructor TDatabaseSchema.Destroy;
begin
  FSequences.Free;

  FTables.Free;

  inherited;
end;

function TDatabaseSchema.GetSequence(const Name: String): TDatabaseSequence;
begin
  Result := TDatabaseNamedObject.FindObject<TDatabaseSequence>(Sequences, Name);
end;

function TDatabaseSchema.GetTable(const Name: String): TDatabaseTable;
begin
  Result := TDatabaseNamedObject.FindObject<TDatabaseTable>(Tables, Name);
end;

{ TDatabaseDefaultConstraint }

constructor TDatabaseDefaultConstraint.Create(const Field: TDatabaseField; const Name, Value: String);
begin
  inherited Create(Name);

  Field.DefaultConstraint := Self;
  FValue := Value;
end;

{ TDatabaseCheckConstraint }

constructor TDatabaseCheckConstraint.Create(const Field: TDatabaseField; const Name, Check: String);
begin
  inherited Create(Name);

  FCheck := Check;
end;

end.

