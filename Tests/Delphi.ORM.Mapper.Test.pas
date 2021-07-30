unit Delphi.ORM.Mapper.Test;

interface

uses System.Rtti, DUnitX.TestFramework, Delphi.ORM.Attributes;

type
  [TestFixture]
  TMapperTest = class
  private
    FContext: TRttiContext;
  public
    [SetupFixture]
    procedure Setup;
    [Test]
    procedure WhenCallLoadAllMustLoadAllClassesWithTheEntityAttribute;
    [Test]
    procedure WhenTryToFindATableMustReturnTheTableOfTheClass;
    [Test]
    procedure WhenTryToFindATableWithoutTheEntityAttributeMustReturnANilValue;
    [Test]
    procedure WhenLoadATableMustLoadAllFieldsToo;
    [Test]
    procedure WhenTheFieldsAreLoadedMustFillTheNameWithTheNameOfPropertyOfTheClass;
    [Test]
    procedure WhenLoadAClassMustKeepTheOrderingOfTablesToTheFindTableContinueToWorking;
    [Test]
    procedure WhenLoadAFieldMustFillThePropertyWithThePropertyInfo;
    [Test]
    procedure WhenAClassDoesNotHaveThePrimaryKeyAttributeAndHasAnIdFieldThisWillBeThePrimaryKey;
    [Test]
    procedure WhenTheClassHaveThePrimaryKeyAttributeThePrimaryKeyWillBeTheFieldFilled;
    [Test]
    procedure TheFieldInPrimaryKeyMustBeMarkedWithInPrimaryKey;
    [Test]
    procedure TheDatabaseNameOfATableMustBeTheNameOfClassRemovingTheFirstCharOfTheClassName;
    [Test]
    procedure WhenTheClassHaveTheTableNameAttributeTheDatabaseNameMustBeLikeTheNameInAttribute;
    [Test]
    procedure OnlyPublishedFieldMutsBeLoadedInTheTable;
    [Test]
    procedure WhenTheFieldHaveTheFieldNameAttributeMustLoadThisNameInTheDatabaseName;
    [Test]
    procedure EveryPropertyThatIsAnObjectMustCreateAForeignKeyInTheListOfTheTable;
    [Test]
    procedure WhenTheForeignKeyIsCreatesMustLoadTheParentTable;
    [Test]
    procedure TheParentTableMustBeTheTableLinkedToTheField;
    [Test]
    procedure WhenTheFieldIsAClassMustFillTheDatabaseNameWithIdPlusPropertyName;
    [Test]
    procedure TheFieldOfAForeignKeyMustBeFilledWithTheFieldOfTheClassThatIsAForeignKey;
    [Test]
    procedure TheLoadingOfForeingKeyMustBeAfterAllTablesAreLoadedToTheFindTableWorksPropertily;
    [Test]
    procedure WhenMapAForeignKeyIsToAClassWithoutAPrimaryKeyMustRaiseAnError;
    [Test]
    procedure WhenCallLoadAllMoreThemOneTimeCantRaiseAnError;
    [Test]
    procedure TheClassWithTheSingleTableInheritanceAttributeCantBeMappedInTheTableList;
    [Test]
    procedure WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeMustLoadAllFieldsInTheTable;
    [Test]
    procedure WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeCantGenerateAnyForeignKey;
    [Test]
    procedure WhenTheClassIsInheritedFromANormalClassCantLoadFieldsFormTheBaseClass;
    [Test]
    procedure WhenTheClassIsInheritedFromANormalClassMustCreateAForeignKeyForTheBaseClass;
    [Test]
    procedure WhenTheClassIsInheritedFromTObjectCantCreateAForeignKeyForThatClass;
    [Test]
    procedure WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeThePrimaryKeyMustBeLoadedFromTheTopClass;
    [Test]
    procedure WhenTheClassIsInheritedFromANormalClassMustCreateAForeignKeyForTheBaseClassWithThePrimaryKeyFields;
    [Test]
    procedure WhenTheClassIsInheritedMustLoadThePrimaryKeyFromBaseClass;
    [Test]
    procedure WhenTheClassIsInheritedMustShareTheSamePrimaryKeyFromTheBaseClass;
    [Test]
    procedure WhenTheForeignKeyIsAClassAliasMustLoadTheForeignClassAndLinkToForeignKey;
    [Test]
    procedure WhenLoadMoreThenOneTimeTheSameClassCantRaiseAnError;
    [Test]
    procedure WhenAPropertyIsAnArrayMustLoadAManyValueLink;
    [Test]
    procedure TheTableOfManyValueAssociationMustBeTheChildTableOfThisLink;
    [Test]
    procedure TheFieldLinkingTheParentAndChildOfManyValueAssociationMustBeLoaded;
    [Test]
    procedure WhenTheChildClassIsDeclaredBeforeTheParentClassTheLinkBetweenOfTablesMustBeCreated;
    [Test]
    procedure TheManyValueAssociationMustLoadTheFieldThatGeneratedTheValue;
    [Test]
    procedure WhenAFieldIsWithTheAutoGeneratedAttributeMustLoadAsTrueThePropertyInField;
    [TestCase('AnsiChar', 'AnsiChar')]
    [TestCase('AnsiString', 'AnsiString')]
    [TestCase('Char', 'Char')]
    [TestCase('Enumerator', 'Enumerator')]
    [TestCase('Float', 'Float')]
    [TestCase('GUID', 'GUID')]
    [TestCase('Integer', 'Integer')]
    [TestCase('Int64', 'Int64')]
    [TestCase('String', 'String')]
    procedure WhenSetValueFieldMustLoadThePropertyOfTheClassAsWithTheValueExpected(FieldName: String);
    [Test]
    procedure WhenTheFieldValueIsNullMustLoadTheFieldWithTheEmptyValue;
    [Test]
    procedure WhenAFieldIsAForeignKeyThePropertyIsForeignKeyMustReturnTrue;
    [Test]
    procedure WhenAFieldIsAManyValueAssociationThePropertyIsManyValueAssociationReturnTrue;
    [Test]
    procedure WhenAFieldIsAForeignKeyThePropertyIsJoinLinkMustReturnTrue;
    [Test]
    procedure WhenAFieldIsAManyValueAssociationThePropertyIsJoinLinkReturnTrue;
    [Test]
    procedure TheFunctionGetValueFromFieldMustReturnTheValueOfThePropertyOfTheField;
    [TestCase('AnsiChar', 'AnsiChar')]
    [TestCase('AnsiString', 'AnsiString')]
    [TestCase('Char', 'Char')]
    [TestCase('Class', 'Class')]
    [TestCase('Empty Class', 'EmptyClass')]
    [TestCase('Enumerator', 'Enumerator')]
    [TestCase('Float', 'Float')]
    [TestCase('Date', 'Date')]
    [TestCase('DateTime', 'DateTime')]
    [TestCase('GUID', 'GUID')]
    [TestCase('Integer', 'Integer')]
    [TestCase('Int64', 'Int64')]
    [TestCase('String', 'String')]
    [TestCase('Time', 'Time')]
    procedure WhenGetTheValueOfTheFieldAsStringMustBuildTheStringAsExpected(FieldName: String);
    [Test]
    procedure WhenTheFieldIsMappedMustLoadTheReferenceToTheTableOfTheField;
    [Test]
    procedure WhenAClassWithManyValueAssociationHasAChildClassWithMoreThenOneForeignKeyToParentClassMustLoadTheForeignKeyWithTheSameNameOfTheParentTable;
    [Test]
    procedure WhenTheLinkBetweenTheManyValueAssociationAndTheChildTableForeignKeyDontExistsMustRaiseAnError;
    [Test]
    procedure TheNameOfManyValueAssociationLinkCanBeDefinedByTheAttributeToTheLinkHappen;
    [Test]
    procedure WhenATableIsLoadedMustFillTheMapperPropertyOfTheTable;
    [TestCase('AnsiChar', 'AnsiChar,''C''')]
    [TestCase('AnsiString', 'AnsiString,''AnsiString''')]
    [TestCase('Char', 'Char,''C''')]
    [TestCase('Class', 'Class,1234')]
    [TestCase('Enumerator', 'Enumerator,1')]
    [TestCase('Empty class', 'EmptyClass,null')]
    [TestCase('Float', 'Float,1234.456')]
    [TestCase('Date', 'Date,''2020-01-31''')]
    [TestCase('DateTime', 'DateTime,''2020-01-31 12:34:56''')]
    [TestCase('GUID', 'GUID,''{BD2BBA84-C691-4C5E-ABD3-4F32937C53F8}''')]
    [TestCase('Integer', 'Integer,1234')]
    [TestCase('Int64', 'Int64,1234')]
    [TestCase('String', 'String,''String''')]
    [TestCase('Time', 'Time,''12:34:56''')]
    procedure TheConversionOfTheTValueMustBeLikeExpected(TypeToConvert, ValueToCompare: String);
    [Test]
    procedure WhenThePropertyIsNullableMustMarkTheFieldAsNullable;
    [Test]
    procedure ThePrimaryKeyCantBeNullable;
    [Test]
    procedure WhenGetValueOfAndFieldNullableMustReturnEmptyIfHasNoValue;
    [Test]
    procedure WhenTheNullablePropertyIsLoadedMustReturnTheFilled;
    [Test]
    procedure WhenTheNullablePropertyIsFilledWithTheNullValueMustMarkAsNullTheValue;
    [Test]
    procedure WhenTheNullablePropertyIsFilledWithAValueMustLoadTheValue;
    [Test]
    procedure WhenThePropertyIsLazyMustFillWithTrueTheIsLazyPropertyInTheField;
    [Test]
    procedure WhenThePropertyIsLazyMustCreateTheForeignKeyToThisProperty;
    [Test]
    procedure TheFieldThatGenerateAForignKeyMustLoadThisInfoInTheField;
    [Test]
    procedure WhenTheFieldIsAForeignKeyMustAppendTheIdInTheDatabaseNameOfTheField;
    [Test]
    procedure TheFieldsMustBeOrderedByPriorityFirstPrimaryKeyThenRegularFieldsThenForeignKeysThenManyValueAssociations;
    [Test]
    procedure WhenThePropertyIsLazyLoadingAndIsntLoadedMustReturnTheKeyValueInTheGetValue;
    [Test]
    procedure WhenTheLazyPropertyIsLoadedMustReturnTheInternalValue;
    [Test]
    procedure WhenGetTheStringValueOfANullableTypeAndTheValueIsNullMustReturnTheNullStringValue;
    [Test]
    procedure WhenGetTheStringValueOfANullableTypeAndTheValueIsFilledMustReturnTheValue;
    [Test]
    procedure WhenGetTheStringValueOfLazyPropertyMustReturnTheKeyValueIfIsNotLoaded;
    [Test]
    procedure WhenGetTheStringValueOfLazyPropertyMustReturnThePrimaryKeyValueOfLoadedValue;
    [Test]
    procedure WhenSetValueToALazyPropertyCantRaiseAnyError;
    [Test]
    procedure WhenSetValueToALazyPropertyMustLoadTheValueInTheProperty;
  end;

implementation

uses System.Variants, System.SysUtils, System.DateUtils, Delphi.ORM.Mapper, Delphi.ORM.Test.Entity, Delphi.ORM.Lazy, Delphi.Mock;

{ TMapperTest }

procedure TMapperTest.EveryPropertyThatIsAnObjectMustCreateAForeignKeyInTheListOfTheTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual<Integer>(2, Length(Table.ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.OnlyPublishedFieldMutsBeLoadedInTheTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntity);

  Assert.AreEqual<Integer>(3, Length(Table.Fields));

  Mapper.Free;
end;

procedure TMapperTest.Setup;
begin
  var Mapper := TMapper.Create;

  try
    Mapper.LoadAll;
  except
  end;

  FContext.GetType(TMyEntity);

  Mapper.Free;
end;

procedure TMapperTest.TheClassWithTheSingleTableInheritanceAttributeCantBeMappedInTheTableList;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.IsNull(Mapper.FindTable(TMyEntityWithSingleTableInheritanceAttribute));

  Mapper.Free;
end;

procedure TMapperTest.TheConversionOfTheTValueMustBeLikeExpected(TypeToConvert, ValueToCompare: String);
begin
  var FieldToCompare: TField := nil;
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntityWithAllTypeOfFields);
  var Value: TValue;

  for var Field in Table.Fields do
    if Field.TypeInfo.Name = TypeToConvert then
      FieldToCompare := Field;

  if TypeToConvert = 'AnsiChar' then
    Value := TValue.From(AnsiChar('C'))
  else if TypeToConvert = 'AnsiString' then
    Value := TValue.From(AnsiString('AnsiString'))
  else if TypeToConvert = 'Char' then
    Value := TValue.From(Char('C'))
  else if TypeToConvert = 'Class' then
  begin
    var Obj := TMyEntityWithPrimaryKey.Create;
    Obj.Value := 1234;
    Value := Obj;
  end
  else if TypeToConvert = 'EmptyClass' then
    Value := TValue.From<TObject>(nil)
  else if TypeToConvert = 'Enumerator' then
    Value := TValue.From(Enum2)
  else if TypeToConvert = 'Float' then
    Value := 1234.456
  else if TypeToConvert = 'Date' then
    Value := TValue.From(EncodeDate(2020, 1, 31))
  else if TypeToConvert = 'DateTime' then
    Value := TValue.From(EncodeDateTime(2020, 1, 31, 12, 34, 56, 0))
  else if TypeToConvert = 'GUID' then
    Value := TValue.From(StringToGUID('{BD2BBA84-C691-4C5E-ABD3-4F32937C53F8}'))
  else if TypeToConvert = 'Integer' then
    Value := 1234
  else if TypeToConvert = 'Int64' then
    Value := Int64(1234)
  else if TypeToConvert = 'String' then
    Value := 'String'
  else if TypeToConvert = 'Time' then
    Value := TValue.From(TTime(EncodeTime(12, 34, 56, 0)))
  else
    raise Exception.Create('Test not mapped!');

  Assert.AreEqual(ValueToCompare, FieldToCompare.GetAsString(Value));

  if Value.IsObject then
    Value.AsObject.Free;

  Mapper.Free;
end;

procedure TMapperTest.TheDatabaseNameOfATableMustBeTheNameOfClassRemovingTheFirstCharOfTheClassName;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity);

  Assert.AreEqual('MyEntity', Table.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.TheFieldInPrimaryKeyMustBeMarkedWithInPrimaryKey;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity);

  Assert.IsTrue(Table.PrimaryKey.InPrimaryKey);

  Mapper.Free;
end;

procedure TMapperTest.TheFieldLinkingTheParentAndChildOfManyValueAssociationMustBeLoaded;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var ChildTable := Mapper.FindTable(TMyEntityWithManyValueAssociationChild);
  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual(ChildTable.Fields[1], Table.ManyValueAssociations[0].ForeignKey.Field);

  Mapper.Free;
end;

procedure TMapperTest.TheFieldOfAForeignKeyMustBeFilledWithTheFieldOfTheClassThatIsAForeignKey;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual(Table.Fields[1], Table.ForeignKeys[0].Field);

  Mapper.Free;
end;

procedure TMapperTest.TheFieldsMustBeOrderedByPriorityFirstPrimaryKeyThenRegularFieldsThenForeignKeysThenManyValueAssociations;
begin
  var Mapper := TMapper.Create;

  var Table := Mapper.LoadClass(TUnorderedClass);

  Assert.AreEqual('Id', Table.Fields[0].DatabaseName);
  Assert.AreEqual('AField', Table.Fields[1].DatabaseName);
  Assert.AreEqual('BField', Table.Fields[2].DatabaseName);
  Assert.AreEqual('LastField', Table.Fields[5].DatabaseName);
  Assert.AreEqual('IdALazy', Table.Fields[3].DatabaseName);
  Assert.AreEqual('IdBLazy', Table.Fields[4].DatabaseName);
  Assert.AreEqual('IdAForeignKey', Table.Fields[6].DatabaseName);
  Assert.AreEqual('IdBForeignKey', Table.Fields[7].DatabaseName);
  Assert.AreEqual('AManyValue', Table.Fields[8].DatabaseName);
  Assert.AreEqual('BManyValue', Table.Fields[9].DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.TheFieldThatGenerateAForignKeyMustLoadThisInfoInTheField;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TClassWithForeignKey);

  Assert.IsNotNull(Table.Fields[1].ForeignKey);

  Mapper.Free;
end;

procedure TMapperTest.TheFunctionGetValueFromFieldMustReturnTheValueOfThePropertyOfTheField;
begin
  var Mapper := TMapper.Create;
  var MyClass := TMyEntityWithAllTypeOfFields.Create;
  MyClass.&String := 'My Field';

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithAllTypeOfFields);
  var Field := Table.Fields[10];

  Assert.AreEqual('My Field', Field.GetValue(MyClass).AsString);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.TheLoadingOfForeingKeyMustBeAfterAllTablesAreLoadedToTheFindTableWorksPropertily;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TZZZZ);

  Assert.IsNotNull(Table.ForeignKeys[0].ParentTable);

  Mapper.Free;
end;

procedure TMapperTest.TheManyValueAssociationMustLoadTheFieldThatGeneratedTheValue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual(Table.Fields[1], Table.ManyValueAssociations[0].Field);

  Mapper.Free;
end;

procedure TMapperTest.TheNameOfManyValueAssociationLinkCanBeDefinedByTheAttributeToTheLinkHappen;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual('ManyValueAssociation', Table.ManyValueAssociations[0].ForeignKey.Field.TypeInfo.Name);

  Mapper.Free;
end;

procedure TMapperTest.TheParentTableMustBeTheTableLinkedToTheField;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var ParentTable := Mapper.FindTable(TMyEntityWithPrimaryKey);
  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual(ParentTable, Table.ForeignKeys[0].ParentTable);

  Mapper.Free;
end;

procedure TMapperTest.ThePrimaryKeyCantBeNullable;
begin
  var Mapper := TMapper.Create;

  Assert.WillRaise(
    procedure
    begin
      Mapper.LoadClass(TClassWithPrimaryKeyNullableProperty);
    end, EClassWithPrimaryKeyNullable);

  Mapper.Free;
end;

procedure TMapperTest.TheTableOfManyValueAssociationMustBeTheChildTableOfThisLink;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var ChildTable := Mapper.FindTable(TMyEntityWithManyValueAssociationChild);
  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual(ChildTable, Table.ManyValueAssociations[0].ChildTable);

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassDoesNotHaveThePrimaryKeyAttributeAndHasAnIdFieldThisWillBeThePrimaryKey;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity2);

  Assert.AreEqual('Id', Table.PrimaryKey.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeCantGenerateAnyForeignKey;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(0, Length(Mapper.FindTable(TMyEntityInheritedFromSingle).ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeMustLoadAllFieldsInTheTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(3, Length(Mapper.FindTable(TMyEntityInheritedFromSingle).Fields));

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassIsInheritedFromAClassWithTheSingleTableInheritanceAttributeThePrimaryKeyMustBeLoadedFromTheTopClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityInheritedFromSingle);

  Assert.IsTrue(Assigned(Table.PrimaryKey));

  Mapper.Free;
end;

procedure TMapperTest.WhenAClassWithManyValueAssociationHasAChildClassWithMoreThenOneForeignKeyToParentClassMustLoadTheForeignKeyWithTheSameNameOfTheParentTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TManyValueAssociationParent);

  Assert.AreEqual('IdManyValueAssociationParent', Table.ManyValueAssociations[0].ForeignKey.Field.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsAForeignKeyThePropertyIsForeignKeyMustReturnTrue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociationChild);

  var Field := Table.Fields[1];

  Assert.IsTrue(Field.IsForeignKey);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsAForeignKeyThePropertyIsJoinLinkMustReturnTrue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociationChild);

  var Field := Table.Fields[1];

  Assert.IsTrue(Field.IsJoinLink);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsAManyValueAssociationThePropertyIsJoinLinkReturnTrue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  var Field := Table.Fields[1];

  Assert.IsTrue(Field.IsJoinLink);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsAManyValueAssociationThePropertyIsManyValueAssociationReturnTrue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  var Field := Table.Fields[1];

  Assert.IsTrue(Field.IsManyValueAssociation);

  Mapper.Free;
end;

procedure TMapperTest.WhenAFieldIsWithTheAutoGeneratedAttributeMustLoadAsTrueThePropertyInField;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity);

  Assert.IsTrue(Table.Fields[0].AutoGenerated);

  Mapper.Free;
end;

procedure TMapperTest.WhenAPropertyIsAnArrayMustLoadAManyValueLink;
begin
  var Mapper := TMapper.Create;

  var Table := Mapper.LoadClass(TMyEntityWithManyValueAssociation);

  Assert.AreEqual<Integer>(1, Length(Table.ManyValueAssociations));

  Mapper.Free;
end;

procedure TMapperTest.WhenATableIsLoadedMustFillTheMapperPropertyOfTheTable;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntityWithAllTypeOfFields);

  Assert.AreEqual(Mapper, Table.Mapper);

  Mapper.Free;
end;

procedure TMapperTest.WhenCallLoadAllMoreThemOneTimeCantRaiseAnError;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.WillNotRaise(Mapper.LoadAll);

  Mapper.Free;
end;

procedure TMapperTest.WhenCallLoadAllMustLoadAllClassesWithTheEntityAttribute;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.IsTrue(Length(Mapper.Tables) > 0, 'No entities loaded!');

  Mapper.Free;
end;

procedure TMapperTest.WhenGetTheStringValueOfANullableTypeAndTheValueIsFilledMustReturnTheValue;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TClassWithNullableProperty);
  var TheValue := TClassWithNullableProperty.Create;
  TheValue.Nullable := 123456;

  Assert.AreEqual('123456', Table.Fields[1].GetAsString(TheValue));

  Mapper.Free;
end;

procedure TMapperTest.WhenGetTheStringValueOfANullableTypeAndTheValueIsNullMustReturnTheNullStringValue;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TClassWithNullableProperty);
  var TheValue := TClassWithNullableProperty.Create;

  Assert.AreEqual('null', Table.Fields[1].GetAsString(TheValue));

  Mapper.Free;
end;

procedure TMapperTest.WhenGetTheStringValueOfLazyPropertyMustReturnTheKeyValueIfIsNotLoaded;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TLazyClass);
  var TheValue := TLazyClass.Create;

  TheValue.Lazy.Access.Key := 123456;

  Assert.AreEqual('123456', Table.Fields[1].GetAsString(TheValue));

  Mapper.Free;
end;

procedure TMapperTest.WhenGetTheStringValueOfLazyPropertyMustReturnThePrimaryKeyValueOfLoadedValue;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TLazyClass);
  var TheValue := TLazyClass.Create;
  TheValue.Lazy := TMyEntity.Create;
  TheValue.Lazy.Value.Id := 123456;

  Assert.AreEqual('123456', Table.Fields[1].GetAsString(TheValue));

  Mapper.Free;
end;

procedure TMapperTest.WhenGetTheValueOfTheFieldAsStringMustBuildTheStringAsExpected(FieldName: String);
begin
  var FieldToCompare: TField := nil;
  var Mapper := TMapper.Create;
  var MyClass := TMyEntityWithAllTypeOfFields.Create;
  var ValueToCompare := EmptyStr;

  var Table := Mapper.LoadClass(TMyEntityWithAllTypeOfFields);

  MyClass.AnsiChar := 'C';
  MyClass.AnsiString := 'AnsiString';
  MyClass.Char := 'C';
  MyClass.&Class := TMyEntityWithPrimaryKey.Create;
  MyClass.&Class.Value := 222.333;
  MyClass.Date := EncodeDate(2020, 1, 31);
  MyClass.DateTime := EncodeDate(2020, 1, 31) + EncodeTime(12, 34, 56, 0);
  MyClass.Enumerator := Enum2;
  MyClass.Float := 1234.456;
  MyClass.GUID := StringToGUID('{BD2BBA84-C691-4C5E-ABD3-4F32937C53F8}');
  MyClass.Integer := 1234;
  MyClass.Int64 := 1234;
  MyClass.&String := 'String';
  MyClass.Time := EncodeTime(12, 34, 56, 0);

  for var Field in Table.Fields do
    if Field.TypeInfo.Name = FieldName then
      FieldToCompare := Field;

  case FieldToCompare.TypeInfo.PropertyType.TypeKind of
    tkChar, tkWChar: ValueToCompare := '''C''';
    tkEnumeration: ValueToCompare := '1';
    tkFloat:
    begin
      if FieldToCompare.TypeInfo.PropertyType.Handle = TypeInfo(TDate) then
        ValueToCompare := '''2020-01-31'''
      else if FieldToCompare.TypeInfo.PropertyType.Handle = TypeInfo(TTime) then
        ValueToCompare := '''12:34:56'''
      else if FieldToCompare.TypeInfo.PropertyType.Handle = TypeInfo(TDateTime) then
        ValueToCompare := '''2020-01-31 12:34:56'''
      else
        ValueToCompare := '1234.456';
    end;
    tkInteger, tkInt64: ValueToCompare := '1234';
    tkRecord: ValueToCompare := '''{BD2BBA84-C691-4C5E-ABD3-4F32937C53F8}''';
    tkLString: ValueToCompare := '''AnsiString''';
    tkUString: ValueToCompare := '''String''';
    tkClass:
      if FieldName = 'Class' then
        ValueToCompare := '222.333'
      else
        ValueToCompare := 'null';
  end;

  Assert.AreEqual(ValueToCompare, FieldToCompare.GetAsString(MyClass));

  MyClass.&Class.Free;

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenGetValueOfAndFieldNullableMustReturnEmptyIfHasNoValue;
begin
  var Mapper := TMapper.Create;
  var MyClass := TClassWithNullableProperty.Create;
  var Table := Mapper.LoadClass(MyClass.ClassType);

  var Field := Table.Fields[1];

  Assert.IsTrue(Field.GetValue(MyClass).IsEmpty);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenLoadAClassMustKeepTheOrderingOfTablesToTheFindTableContinueToWorking;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadClass(TMyEntity2);

  Mapper.LoadClass(TMyEntity);

  Mapper.LoadClass(TMyEntity3);

  var Table := Mapper.FindTable(TMyEntity);

  Assert.AreSame(FContext.GetType(TMyEntity), Table.TypeInfo);

  Mapper.Free;
end;

procedure TMapperTest.WhenLoadAFieldMustFillThePropertyWithThePropertyInfo;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity3);
  var TypeInfo := FContext.GetType(TMyEntity3).GetProperties[0];

  Assert.AreEqual<TObject>(TypeInfo, Table.Fields[0].TypeInfo);

  Mapper.Free;
end;

procedure TMapperTest.WhenLoadATableMustLoadAllFieldsToo;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntity);

  Assert.AreEqual<Integer>(3, Length(Table.Fields));

  Mapper.Free;
end;

procedure TMapperTest.WhenLoadMoreThenOneTimeTheSameClassCantRaiseAnError;
begin
  var Mapper := TMapper.Create;

  Assert.WillNotRaise(
    procedure
    begin
      Mapper.LoadClass(TMyEntity);

      Mapper.LoadClass(TMyEntity);
    end);

  Mapper.Free;
end;

procedure TMapperTest.WhenMapAForeignKeyIsToAClassWithoutAPrimaryKeyMustRaiseAnError;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.WillRaise(
    procedure
    begin
      Mapper.LoadClass(TMyEntityForeignKeyToClassWithoutPrimaryKey);
    end, EClassWithoutPrimaryKeyDefined);

  Mapper.Free;
end;

procedure TMapperTest.WhenSetValueFieldMustLoadThePropertyOfTheClassAsWithTheValueExpected(FieldName: String);
begin
  var FieldToCompare: TField := nil;
  var Mapper := TMapper.Create;
  var MyClass := TMyEntityWithAllTypeOfFields.Create;
  var ValueToCompare := NULL;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithAllTypeOfFields);

  for var Field in Table.Fields do
    if Field.DatabaseName = FieldName then
      FieldToCompare := Field;

  case FieldToCompare.TypeInfo.PropertyType.TypeKind of
    tkChar: ValueToCompare := AnsiChar('C');
    tkEnumeration: ValueToCompare := Enum2;
    tkFloat: ValueToCompare := Double(1234.456);
    tkInt64: ValueToCompare := Int64(1234);
    tkInteger: ValueToCompare := 1234;
    tkRecord: ValueToCompare := '{BD2BBA84-C691-4C5E-ABD3-4F32937C53F8}';
    tkLString: ValueToCompare := AnsiString('AnsiString');
    tkUString: ValueToCompare := 'String';
    tkWChar: ValueToCompare := Char('C');
  end;

  FieldToCompare.SetValue(MyClass, ValueToCompare);

  if FieldToCompare.TypeInfo.PropertyType.TypeKind = tkRecord then
    Assert.AreEqual<String>(ValueToCompare, FieldToCompare.GetValue(MyClass).AsType<TGUID>.ToString)
  else
    Assert.AreEqual(ValueToCompare, FieldToCompare.GetValue(MyClass).AsVariant);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenSetValueToALazyPropertyCantRaiseAnyError;
begin
  var LazyValue := TMyEntity.Create;
  var Mapper := TMapper.Create;
  var MyClass := TLazyClass.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TLazyClass);

  var Field := Table.Fields[1];

  Assert.WillNotRaise(
    procedure
    begin
      Field.SetValue(MyClass, LazyValue);
    end);

  Mapper.Free;

  MyClass.Free;

  LazyValue.Free;
end;

procedure TMapperTest.WhenSetValueToALazyPropertyMustLoadTheValueInTheProperty;
begin
  var LazyValue := TMyEntity.Create;
  var Mapper := TMapper.Create;
  var MyClass := TLazyClass.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TLazyClass);

  var Field := Table.Fields[1];

  Field.SetValue(MyClass, LazyValue);

  Assert.AreEqual<TObject>(LazyValue, Field.GetValue(MyClass).AsObject);

  Mapper.Free;

  MyClass.Free;

  LazyValue.Free;
end;

procedure TMapperTest.WhenTheChildClassIsDeclaredBeforeTheParentClassTheLinkBetweenOfTablesMustBeCreated;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithManyValueAssociation);

  Assert.AreEqual<Integer>(1, Length(Table.ManyValueAssociations));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassHaveThePrimaryKeyAttributeThePrimaryKeyWillBeTheFieldFilled;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntityWithPrimaryKey);

  Assert.AreEqual('Value', Table.PrimaryKey.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassHaveTheTableNameAttributeTheDatabaseNameMustBeLikeTheNameInAttribute;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity2);

  Assert.AreEqual('AnotherTableName', Table.DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedFromANormalClassCantLoadFieldsFormTheBaseClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(1, Length(Mapper.FindTable(TMyEntityInheritedFromSimpleClass).Fields));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedFromANormalClassMustCreateAForeignKeyForTheBaseClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(1, Length(Mapper.FindTable(TMyEntityInheritedFromSimpleClass).ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedFromANormalClassMustCreateAForeignKeyForTheBaseClassWithThePrimaryKeyFields;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityInheritedFromSimpleClass);

  var ForeignKey := Table.ForeignKeys[0];

  Assert.AreEqual(Table.PrimaryKey, ForeignKey.Field);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedFromTObjectCantCreateAForeignKeyForThatClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.AreEqual<Integer>(0, Length(Mapper.FindTable(TMyEntity).ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedMustLoadThePrimaryKeyFromBaseClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityInheritedFromSimpleClass);

  Assert.IsTrue(Assigned(Table.PrimaryKey));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheClassIsInheritedMustShareTheSamePrimaryKeyFromTheBaseClass;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var BaseTable := Mapper.FindTable(TMyEntityInheritedFromSingle);
  var Table := Mapper.FindTable(TMyEntityInheritedFromSimpleClass);

  Assert.AreSame(BaseTable.PrimaryKey, Table.PrimaryKey);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldHaveTheFieldNameAttributeMustLoadThisNameInTheDatabaseName;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual('AnotherFieldName', Table.Fields[0].DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldIsAClassMustFillTheDatabaseNameWithIdPlusPropertyName;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.AreEqual('IdMyForeignKey', Table.Fields[1].DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldIsAForeignKeyMustAppendTheIdInTheDatabaseNameOfTheField;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TLazyClass);

  Assert.AreEqual('IdLazy', Table.Fields[1].DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldIsMappedMustLoadTheReferenceToTheTableOfTheField;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity);

  Assert.AreEqual(Table, Table.Fields[0].Table);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldsAreLoadedMustFillTheNameWithTheNameOfPropertyOfTheClass;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity3);

  Assert.AreEqual('Id', Table.Fields[0].DatabaseName);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheFieldValueIsNullMustLoadTheFieldWithTheEmptyValue;
begin
  var Mapper := TMapper.Create;
  var MyClass := TMyEntityWithAllTypeOfFields.Create;
  MyClass.Enumerator := Enum3;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithAllTypeOfFields);

  var Field := Table.Fields[6];

  Field.SetValue(MyClass, NULL);

  Assert.AreEqual(Enum1, Field.GetValue(MyClass).AsType<TMyEnumerator>);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenTheForeignKeyIsAClassAliasMustLoadTheForeignClassAndLinkToForeignKey;
begin
  var Mapper := TMapper.Create;

  var Table := Mapper.LoadClass(TMyEntityWithForeignKeyAlias);

  Assert.AreEqual<Integer>(1, Length(Table.ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.WhenTheForeignKeyIsCreatesMustLoadTheParentTable;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithFieldNameAttribute);

  Assert.IsNotNull(Table.ForeignKeys[0].ParentTable);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheLazyPropertyIsLoadedMustReturnTheInternalValue;
begin
  var Mapper := TMapper.Create;
  var MyClass := TLazyClass.Create;
  var TheClass := TMyEntity.Create;

  MyClass.Lazy := TheClass;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TLazyClass);
  var Field := Table.Fields[1];

  Assert.AreEqual<TObject>(TheClass, Field.GetValue(MyClass).AsObject);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenTheLinkBetweenTheManyValueAssociationAndTheChildTableForeignKeyDontExistsMustRaiseAnError;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  Assert.WillRaise(
    procedure
    begin
      Mapper.LoadClass(TManyValueAssociationParentNoLink);
    end, EManyValueAssociationLinkError);

  Mapper.Free;
end;

procedure TMapperTest.WhenTheNullablePropertyIsFilledWithAValueMustLoadTheValue;
begin
  var Mapper := TMapper.Create;
  var MyClass := TClassWithNullableProperty.Create;
  var Table := Mapper.LoadClass(MyClass.ClassType);

  var Field := Table.Fields[1];

  Field.SetValue(MyClass, 123456);

  Assert.AreEqual<Integer>(123456, MyClass.Nullable.Value);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenTheNullablePropertyIsFilledWithTheNullValueMustMarkAsNullTheValue;
begin
  var Mapper := TMapper.Create;
  var MyClass := TClassWithNullableProperty.Create;
  var Table := Mapper.LoadClass(MyClass.ClassType);

  var Field := Table.Fields[1];

  Field.SetValue(MyClass, Null);

  Assert.IsTrue(MyClass.Nullable.IsNull);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenTheNullablePropertyIsLoadedMustReturnTheFilled;
begin
  var Mapper := TMapper.Create;
  var MyClass := TClassWithNullableProperty.Create;
  MyClass.Nullable := 123456;
  var Table := Mapper.LoadClass(MyClass.ClassType);

  var Field := Table.Fields[1];

  Assert.AreEqual(123456, Field.GetValue(MyClass).AsInteger);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenThePropertyIsLazyLoadingAndIsntLoadedMustReturnTheKeyValueInTheGetValue;
begin
  var Mapper := TMapper.Create;
  var MyClass := TLazyClass.Create;

  MyClass.Lazy.Access.Key := 12345;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TLazyClass);
  var Field := Table.Fields[1];

  Assert.AreEqual(12345, Field.GetValue(MyClass).AsInteger);

  Mapper.Free;

  MyClass.Free;
end;

procedure TMapperTest.WhenThePropertyIsLazyMustCreateTheForeignKeyToThisProperty;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TLazyClass);

  Assert.AreEqual<Integer>(1, Length(Table.ForeignKeys));

  Mapper.Free;
end;

procedure TMapperTest.WhenThePropertyIsLazyMustFillWithTrueTheIsLazyPropertyInTheField;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TLazyClass);

  Assert.IsTrue(Table.Fields[1].IsLazy);

  Mapper.Free;
end;

procedure TMapperTest.WhenThePropertyIsNullableMustMarkTheFieldAsNullable;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TClassWithNullableProperty);

  Assert.IsTrue(Table.Fields[1].IsNullable);

  Mapper.Free;
end;

procedure TMapperTest.WhenTryToFindATableMustReturnTheTableOfTheClass;
begin
  var Mapper := TMapper.Create;
  var Table := Mapper.LoadClass(TMyEntity3);

  Assert.AreEqual(TMyEntity3, Table.TypeInfo.MetaclassType);

  Mapper.Free;
end;

procedure TMapperTest.WhenTryToFindATableWithoutTheEntityAttributeMustReturnANilValue;
begin
  var Mapper := TMapper.Create;

  Mapper.LoadAll;

  var Table := Mapper.FindTable(TMyEntityWithoutEntityAttribute);

  Assert.IsNull(Table);

  Mapper.Free;
end;

end.

