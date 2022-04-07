﻿unit Delphi.ORM.Test.Entity;

interface

uses Delphi.ORM.Attributes, Delphi.ORM.Nullable, Delphi.ORM.Lazy;

type
  TMyEntityInheritedFromSimpleClass = class;

  [Entity]
  TMyEntityForeignKeyAlias = class
  private
    FForeignKey: TMyEntityInheritedFromSimpleClass;
  published
    property ForeignKey: TMyEntityInheritedFromSimpleClass read FForeignKey write FForeignKey;
  end;

  [Entity]
  TAutoGeneratedClass = class
  private
    FId: Integer;
    FValue: String;
    FAnotherField: String;
  published
    [AutoGenerated]
    property Id: Integer read FId write FId;
    [AutoGenerated]
    property AnotherField: String read FAnotherField write FAnotherField;
    property Value: String read FValue write FValue;
  end;

  [Entity]
  TMyTestClass = class
  private
    FField: Integer;
    FName: String;
    FValue: Double;
    FPublicField: String;
  public
    property PublicField: String read FPublicField write FPublicField;
  published
    property Field: Integer read FField write FField;
    property Name: String read FName write FName;
    property Value: Double read FValue write FValue;
  end;

  [Entity]
  TClassOnlyPublic = class
  private
    FName: String;
    FValue: Integer;
  public
    property Name: String read FName write FName;
    property Value: Integer read FValue write FValue;
  end;

  [Entity]
  [PrimaryKey('Id2')]
  TClassWithPrimaryKeyAttribute = class
  private
    FId: Integer;
    FId2: Integer;
    FValue: Integer;
  published
    property Id: Integer read FId write FId;
    property Id2: Integer read FId2 write FId2;
    property Value: Integer read FValue write FValue;
  end;

  [Entity]
  TClassWithPrimaryKey = class
  private
    FId: Integer;
    FValue: Integer;
  published
    property Id: Integer read FId write FId;
    property Value: Integer read FValue write FValue;
  end;

  [Entity]
  TClassWithForeignKey = class
  private
    FAnotherClass: TClassWithPrimaryKey;
    FId: Integer;
  published
    [InsertCascade, UpdateCascade]
    property AnotherClass: TClassWithPrimaryKey read FAnotherClass write FAnotherClass;
    property Id: Integer read FId write FId;
  end;

  [Entity]
  TClassWithTwoForeignKey = class
  private
    FAnotherClass: TClassWithPrimaryKey;
    FAnotherClass2: TClassWithPrimaryKey;
    FId: Integer;
  published
    property AnotherClass: TClassWithPrimaryKey read FAnotherClass write FAnotherClass;
    property AnotherClass2: TClassWithPrimaryKey read FAnotherClass2 write FAnotherClass2;
    property Id: Integer read FId write FId;
  end;

  [Entity]
  [PrimaryKey('AnotherClass')]
  TClassWithTwoForeignKeyAndOneIsAPrimaryKey = class
  private
    FAnotherClass: TClassWithPrimaryKey;
    FAnotherClass2: TClassWithPrimaryKey;
  published
    property AnotherClass: TClassWithPrimaryKey read FAnotherClass write FAnotherClass;
    property AnotherClass2: TClassWithPrimaryKey read FAnotherClass2 write FAnotherClass2;
  end;

  [Entity]
  TClassWithForeignKeyRecursive = class
  private
    FAnotherClass: TClassWithForeignKey;
    FId: Integer;
  published
    property AnotherClass: TClassWithForeignKey read FAnotherClass write FAnotherClass;
    property Id: Integer read FId write FId;
  end;

  TClassRecursiveThrid = class;

  [Entity]
  TClassRecursiveFirst = class
  private
    FId: Integer;
    FRecursive: TClassRecursiveThrid;
  published
    property Id: Integer read FId write FId;
    property Recursive: TClassRecursiveThrid read FRecursive write FRecursive;
  end;

  [Entity]
  TClassRecursiveSecond = class
  private
    FId: Integer;
    FRecursive: TClassRecursiveFirst;
  published
    property Id: Integer read FId write FId;
    property Recursive: TClassRecursiveFirst read FRecursive write FRecursive;
  end;

  [Entity]
  TClassRecursiveThrid = class
  private
    FId: Integer;
    FRecursive: TClassRecursiveSecond;
  published
    property Id: Integer read FId write FId;
    property Recursive: TClassRecursiveSecond read FRecursive write FRecursive;
  end;

  TClassHierarchy2 = class;
  TClassHierarchy3 = class;

  [Entity]
  TClassHierarchy1 = class
  private
    FClass1: TClassHierarchy2;
    FId: Integer;
    FClass3: TClassHierarchy3;
  published
    property Class1: TClassHierarchy2 read FClass1 write FClass1;
    property Class2: TClassHierarchy3 read FClass3 write FClass3;
    property Id: Integer read FId write FId;
  end;

  [Entity]
  TClassHierarchy2 = class
  private
    FId: Integer;
    FClass2: TClassHierarchy1;
    FClass3: TClassHierarchy1;
  published
    property Class3: TClassHierarchy1 read FClass2 write FClass2;
    property Class4: TClassHierarchy1 read FClass3 write FClass3;
    property Id: Integer read FId write FId;
  end;

  [Entity]
  TClassHierarchy3 = class
  private
    FId: Integer;
    FValue: String;
  published
    property Id: Integer read FId write FId;
    property Value: String read FValue write FValue;
  end;

  [Entity]
  TClassRecursiveItSelf = class
  private
    FId: Integer;
    FRecursive1: TClassRecursiveItSelf;
    FRecursive2: TClassRecursiveItSelf;
  published
    property Id: Integer read FId write FId;
    property Recursive1: TClassRecursiveItSelf read FRecursive1 write FRecursive1;
    property Recursive2: TClassRecursiveItSelf read FRecursive2 write FRecursive2;
  end;

  TMyEntityWithManyValueAssociation = class;

  [Entity]
  TMyEntityWithManyValueAssociationChild = class
  private
    FId: Integer;
    FManyValueAssociation: TMyEntityWithManyValueAssociation;
  published
    property Id: Integer read FId write FId;
    property ManyValueAssociation: TMyEntityWithManyValueAssociation read FManyValueAssociation write FManyValueAssociation;
  end;

  [Entity]
  TMyEntityWithManyValueAssociation = class
  private
    FId: Integer;
    FManyValueAssociation: TArray<TMyEntityWithManyValueAssociationChild>;
  published
    property Id: Integer read FId write FId;
    [ManyValueAssociationLinkName('ManyValueAssociation')]
    property ManyValueAssociationList: TArray<TMyEntityWithManyValueAssociationChild> read FManyValueAssociation write FManyValueAssociation;
  end;

  [Entity]
  TMyEntityWithPrimaryKeyInLastField = class
  private
    FField1: Integer;
    FField2: Integer;
    FField3: String;
    FId: Integer;
  published
    property Field1: Integer read FField1 write FField1;
    property Field2: Integer read FField2 write FField2;
    property Field3: String read FField3 write FField3;
    property Id: Integer read FId write FId;
  end;

  [Entity]
  [PrimaryKey('Name')]
  TMyClass = class
  private
    FName: String;
    FValue: Integer;
  published
    property Name: String read FName write FName;
    property Value: Integer read FValue write FValue;
  end;

  TMyEnumerator = (Enum1, Enum2, Enum3, Enum4);

  [Entity]
  TMyClassWithSpecialTypes = class
  private
    FGuid: TGUID;
    FEnumerator: TMyEnumerator;
  published
    property Enumerator: TMyEnumerator read FEnumerator write FEnumerator;
    property Guid: TGUID read FGuid write FGuid;
  end;

  [Entity]
  TClassForeignKey = class
  private
    FId: Integer;
    FField1: String;
    FField2: Double;
  published
    property Id: Integer read FId write FId;
    property Field1: String read FField1 write FField1;
    property Field2: Double read FField2 write FField2;
  end;

  [Entity]
  TClassWithThreeForeignKey = class
  private
    FId: Integer;
    FForeignKey1: TClassForeignKey;
    FForeignKey2: TClassForeignKey;
    FForeignKey3: TClassForeignKey;
  published
    property Id: Integer read FId write FId;
    property ForeignKey1: TClassForeignKey read FForeignKey1 write FForeignKey1;
    property ForeignKey2: TClassForeignKey read FForeignKey2 write FForeignKey2;
    property ForeignKey3: TClassForeignKey read FForeignKey3 write FForeignKey3;
  end;

  [Entity]
  TClassWithSubForeignKey = class
  private
    FId: Integer;
    FForeignKey2: TClassWithThreeForeignKey;
    FForeignKey1: TClassWithThreeForeignKey;
  published
    property Id: Integer read FId write FId;
    property ForeignKey1: TClassWithThreeForeignKey read FForeignKey1 write FForeignKey1;
    property ForeignKey2: TClassWithThreeForeignKey read FForeignKey2 write FForeignKey2;
  end;

  TManyValueAssociationParent = class;

  [Entity]
  TManyValueAssociationWithThreeForeignKey = class
  private
    FId: Integer;
    FForeignKeyOne: TManyValueAssociationParent;
    FForeignKeyTwo: TManyValueAssociationParent;
    FManyValueAssociationParent: TManyValueAssociationParent;
  published
    property Id: Integer read FId write FId;
    [UpdateCascade]
    property ForeignKeyOne: TManyValueAssociationParent read FForeignKeyOne write FForeignKeyOne;
    [InsertCascade]
    property ForeignKeyTwo: TManyValueAssociationParent read FForeignKeyTwo write FForeignKeyTwo;
    [InsertCascade, UpdateCascade]
    property ManyValueAssociationParent: TManyValueAssociationParent read FManyValueAssociationParent write FManyValueAssociationParent;
  end;

  [Entity]
  TManyValueAssociationParent = class
  private
    FId: Integer;
    FChildClass: TArray<TManyValueAssociationWithThreeForeignKey>;
  published
    property Id: Integer read FId write FId;
    property ChildClass: TArray<TManyValueAssociationWithThreeForeignKey> read FChildClass write FChildClass;
  end;

  TManyValueAssociationParentNoLink = class
  private
    FChildClass: TArray<TManyValueAssociationWithThreeForeignKey>;
    FId: Integer;
  published
    property Id: Integer read FId write FId;
    property ChildClass: TArray<TManyValueAssociationWithThreeForeignKey> read FChildClass write FChildClass;
  end;

  [Entity]
  TMyEntity = class
  private
    FId: Integer;
    FName: String;
    FValue: Double;
    FPublicField: String;
  public
    property PublicField: String read FPublicField write FPublicField;
  published
    [AutoGenerated]
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
    property Value: Double read FValue write FValue;
  end;

  [Entity]
  [TableName('AnotherTableName')]
  TMyEntity2 = class
  private
    FId: Integer;
    FName: String;
    FValue: Double;
    FAField: Integer;
  published
    property AField: Integer read FAField write FAField;
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
    property Value: Double read FValue write FValue;
  end;

  [Entity]
  TMyEntity3 = class
  private
    FId: Integer;
  published
    property Id: Integer read FId write FId;
  end;

  [Entity]
  [PrimaryKey('Value')]
  TMyEntityWithPrimaryKey = class
  private
    FId: Integer;
    FValue: Double;
  published
    property Id: Integer read FId write FId;
    property Value: Double read FValue write FValue;
  end;

  [Entity]
  TMyEntityWithFieldNameAttribute = class
  private
    FName: String;
    FMyForeignKey: TMyEntityWithPrimaryKey;
    FMyForeignKey2: TMyEntity2;
  published
    [FieldName('AnotherFieldName')]
    property Name: String read FName write FName;
    property MyForeignKey: TMyEntityWithPrimaryKey read FMyForeignKey write FMyForeignKey;
    property MyForeignKey2: TMyEntity2 read FMyForeignKey2 write FMyForeignKey2;
  end;

  TMyEntityWithoutEntityAttribute = class
  private
    FId: Integer;
    FName: String;
    FValue: Double;
  published
    property Id: Integer read FId write FId;
    property Name: String read FName write FName;
    property Value: Double read FValue write FValue;
  end;

  [Entity]
  TAAAA = class
  private
    FId: Integer;
    FValue: String;
  published
    property Id: Integer read FId write FId;
    property Value: String read FValue write FValue;
  end;

  [Entity]
  TZZZZ = class
  private
    FId: Integer;
    FAAAA: TAAAA;
  published
    property AAAA: TAAAA read FAAAA write FAAAA;
    property Id: Integer read FId write FId;
  end;

  [Entity]
  TMyEntityWithoutPrimaryKey = class
  private
    FValue: String;
  published
    property Value: String read FValue write FValue;
  end;

  TMyEntityForeignKeyToClassWithoutPrimaryKey = class
  private
    FValue: String;
    FId: Integer;
    FForerignKey: TMyEntityWithoutPrimaryKey;
  published
    property Id: Integer read FId write FId;
    property ForerignKey: TMyEntityWithoutPrimaryKey read FForerignKey write FForerignKey;
    property Value: String read FValue write FValue;
  end;

  [SingleTableInheritance]
  TMyEntityWithSingleTableInheritanceAttribute = class
  private
    FId: Integer;
    FBaseProperty: String;
  published
    property BaseProperty: String read FBaseProperty write FBaseProperty;
    [AutoGenerated]
    property Id: Integer read FId write FId;
  end;

  [Entity]
  TMyEntityInheritedFromSingle = class(TMyEntityWithSingleTableInheritanceAttribute)
  private
    FAnotherProperty: String;
  published
    property AnotherProperty: String read FAnotherProperty write FAnotherProperty;
  end;

  [Entity]
  TMyEntityInheritedFromSimpleClass = class(TMyEntityInheritedFromSingle)
  private
    FSimpleProperty: Integer;
  published
    property SimpleProperty: Integer read FSimpleProperty write FSimpleProperty;
  end;

  [SingleTableInheritance]
  TAnotherSingleInherited = class(TMyEntityWithSingleTableInheritanceAttribute)
  private
    FAProperty: String;
  published
    property AProperty: String read FAProperty write FAProperty;
  end;

  [Entity]
  TAnotherSingleInheritedConcrete = class(TAnotherSingleInherited)
  private
    FValue: String;
  published
    property Value: String read FValue write FValue;
  end;

  TMyEntityForeignKeyToAnotherSingle = class
  private
    FId: String;
    FMyForeignKey: TAnotherSingleInherited;
  published
    property Id: String read FId write FId;
    property MyForeignKey: TAnotherSingleInherited read FMyForeignKey write FMyForeignKey;
  end;

  [Entity]
  TMyEntityForeignKeyToConcrete = class
  private
    FAnotherClass: TAnotherSingleInheritedConcrete;
    FId: Integer;
  published
    property AnotherClass: TAnotherSingleInheritedConcrete read FAnotherClass write FAnotherClass;
    property Id: Integer read FId write FId;
  end;

  TMyEntityAlias = class;

  TMyEntityWithForeignKeyAlias = class
  private
    FId: Integer;
    FForeignKey: TMyEntity;
  published
    property ForeignKey: TMyEntity read FForeignKey write FForeignKey;
    property Id: Integer read FId write FId;
  end;

  TMyEntityAlias = class
  private
    FId: Integer;
  published
    property Id: Integer read FId write FId;
  end;

  [Entity]
  [PrimaryKey('Integer')]
  TMyEntityWithAllTypeOfFields = class
  private
    FString: String;
    FInteger: Integer;
    FChar: Char;
    FAnsiString: AnsiString;
    FAnsiChar: AnsiChar;
    FInt64: Int64;
    FFloat: Double;
    FEnumerator: TMyEnumerator;
    FGUID: TGUID;
    FDate: TDate;
    FTime: TTime;
    FDateTime: TDateTime;
    FClass: TMyEntityWithPrimaryKey;
    FEmptyClass: TMyEntityWithPrimaryKey;
  published
    property AnsiChar: AnsiChar read FAnsiChar write FAnsiChar;
    property AnsiString: AnsiString read FAnsiString write FAnsiString;
    property Char: Char read FChar write FChar;
    property Enumerator: TMyEnumerator read FEnumerator write FEnumerator;
    property Float: Double read FFloat write FFloat;
    property GUID: TGUID read FGUID write FGUID;
    property Integer: Integer read FInteger write FInteger;
    property Int64: Int64 read FInt64 write FInt64;
    property &String: String read FString write FString;
    property &Class: TMyEntityWithPrimaryKey read FClass write FClass;
    property EmptyClass: TMyEntityWithPrimaryKey read FEmptyClass write FEmptyClass;
    property Date: TDate read FDate write FDate;
    property DateTime: TDateTime read FDateTime write FDateTime;
    property Time: TTime read FTime write FTime;
  end;

  TMyChildClass = class;
  TMyClassParent = class;

  [Entity]
  TMyChildChildClass = class
  private
    FId: Integer;
    FValue: String;
    FMyChildClass: TMyChildClass;
  published
    property Id: Integer read FId write FId;
    property MyChildClass: TMyChildClass read FMyChildClass write FMyChildClass;
    property Value: String read FValue write FValue;
  end;

  [Entity]
  TMyChildClass = class
  private
    FId: Integer;
    FValue: String;
    FChild: TArray<TMyChildChildClass>;
    FMyClassParent: TMyClassParent;
  published
    property Child: TArray<TMyChildChildClass> read FChild write FChild;
    property Id: Integer read FId write FId;
    property MyClassParent: TMyClassParent read FMyClassParent write FMyClassParent;
    property Value: String read FValue write FValue;
  end;

  [Entity]
  TMyClassParent = class
  private
    FId: Integer;
    FChild: TArray<TMyChildClass>;
  published
    property Child: TArray<TMyChildClass> read FChild write FChild;
    property Id: Integer read FId write FId;
  end;

  [Entity]
  TWhereClassTest = class
  private
    FMyField: Integer;
    FField1: Integer;
    FField2: Integer;
    FField3: Integer;
    FField4: Integer;
    FValue: Integer;
    FWhere: TClassHierarchy1;
    FId: Integer;
  published
    property Field1: Integer read FField1 write FField1;
    property Field2: Integer read FField2 write FField2;
    property Field3: Integer read FField3 write FField3;
    property Field4: Integer read FField4 write FField4;
    property Id: Integer read FId write FId;
    property MyField: Integer read FMyField write FMyField;
    property Value: Integer read FValue write FValue;
    property Where: TClassHierarchy1 read FWhere write FWhere;
  end;

  [Entity]
  TClassWithNullableProperty = class
  private
    FId: Integer;
    FNullable: Nullable<Integer>;
  published
    property Id: Integer read FId write FId;
    property Nullable: Nullable<Integer> read FNullable write FNullable;
  end;

  TClassWithPrimaryKeyNullableProperty = class
  private
    FId: Nullable<Integer>;
  published
    property Id: Nullable<Integer> read FId write FId;
  end;

  [Entity]
  TLazyClass = class
  private
    FId: Integer;
    FLazy: Lazy<TMyEntity>;
  published
    property Id: Integer read FId write FId;
    property Lazy: Lazy<TMyEntity> read FLazy write FLazy;
  end;

  [Entity]
  TUnorderedClass = class
  private
    FAField: String;
    FBField: Integer;
    FId: Integer;
    FAManyValue: TArray<TUnorderedClass>;
    FBManyValue: TArray<TUnorderedClass>;
    FBForeignKey: TUnorderedClass;
    FAForeignKey: TUnorderedClass;
    FALazy: Lazy<TUnorderedClass>;
    FBLazy: Lazy<TUnorderedClass>;
    FLastField: String;
  published
    property BField: Integer read FBField write FBField;
    property AField: String read FAField write FAField;
    property Id: Integer read FId write FId;
    [ManyValueAssociationLinkName('BForeignKey')]
    property BManyValue: TArray<TUnorderedClass> read FBManyValue write FBManyValue;
    [ManyValueAssociationLinkName('AForeignKey')]
    property AManyValue: TArray<TUnorderedClass> read FAManyValue write FAManyValue;
    property BLazy: Lazy<TUnorderedClass> read FBLazy write FBLazy;
    property ALazy: Lazy<TUnorderedClass> read FALazy write FALazy;
    property BForeignKey: TUnorderedClass read FBForeignKey write FBForeignKey;
    property AForeignKey: TUnorderedClass read FAForeignKey write FAForeignKey;
    property LastField: String read FLastField write FLastField;
  end;

  [Entity]
  TMyEntityWithDefaultValue = class
  private
    FId: Integer;
    FAField: String;
    FAEnum: TMyEnumerator;
    FDate: TDate;
    FTime: TTime;
    FDateTime: TDateTime;
    FInt: Integer;
    FFloat: Double;
  published
    property Id: Integer read FId write FId;
    [DefaultValue('abcde')]
    property AField: String read FAField write FAField;
    [DefaultValue('Enum3')]
    property AEnum: TMyEnumerator read FAEnum write FAEnum;
    [DefaultValue('08/02/2021')]
    property Date: TDate read FDate write FDate;
    [DefaultValue('11:00:30')]
    property Time: TTime read FTime write FTime;
    [DefaultValue('08/02/2021 11:00:30')]
    property DateTime: TDateTime read FDateTime write FDateTime;
    [DefaultValue('123456')]
    property Int: Integer read FInt write FInt;
    [DefaultValue('123.456')]
    property Float: Double read FFloat write FFloat;
  end;

  TMyEntityWithInvalidDefaultValue = class
  private
    FAEnum: TMyEnumerator;
  published
    [DefaultValue('InvalidName')]
    property AEnum: TMyEnumerator read FAEnum write FAEnum;
  end;

  TManyValueParent = class;

  [Entity]
  TManyValueChild = class
  private
    FId: Integer;
    FParent: TManyValueParent;
  published
    property Id: Integer read FId write FId;
    property Parent: TManyValueParent read FParent write FParent;
  end;

  [Entity]
  TManyValueParent = class
  private
    FId: Integer;
    FChild: TManyValueChild;
    FChilds: TArray<TManyValueChild>;
  published
    property Child: TManyValueChild read FChild write FChild;
    [ManyValueAssociationLinkName('Parent')]
    property Childs: TArray<TManyValueChild> read FChilds write FChilds;
    property Id: Integer read FId write FId;
  end;

  TManyValueParentInherited = class;

  [Entity]
  TManyValueChildInheritedBase = class
  private
    FId: Integer;
    FValue: TClassWithPrimaryKey;
  published
    property Id: Integer read FId write FId;
    property Value: TClassWithPrimaryKey read FValue write FValue;
  end;

  [Entity]
  TManyValueChildInherited = class(TManyValueChildInheritedBase)
  private
    FParent: TManyValueParentInherited;
  published
    property Parent: TManyValueParentInherited read FParent write FParent;
  end;

  [Entity]
  TManyValueParentInherited = class
  private
    FId: Integer;
    FChilds: TArray<TManyValueChildInherited>;
  published
    [ManyValueAssociationLinkName('Parent')]
    property Childs: TArray<TManyValueChildInherited> read FChilds write FChilds;
    property Id: Integer read FId write FId;
  end;

  TManyValueParentError = class;

  [Entity]
  TManyValueParentChildError = class
  private
    FId: Integer;
    FParent: TManyValueParentError;
    FPassCount: Integer;
    function GetParent: TManyValueParentError;
  published
    property Id: Integer read FId write FId;
    property ManyValueParentError: TManyValueParentError read GetParent write FParent;
  end;

  [Entity]
  TManyValueParentError = class
  private
    FId: Integer;
    FValues: TArray<TManyValueParentChildError>;
    FPassCount: Integer;
  published
    property Id: Integer read FId write FId;
    property PassCount: Integer read FPassCount write FPassCount;
    property Values: TArray<TManyValueParentChildError> read FValues write FValues;
  end;

  [Entity]
  TClassWithNamedForeignKey = class
  private
    FId: Integer;
    FForeignKey: TMyEntity;
  published
    property Id: Integer read FId write FId;
    [FieldName('MyFk')]
    property ForeignKey: TMyEntity read FForeignKey write FForeignKey;
  end;

  [Entity]
  TClassWithCascadeForeignClass = class
  private
    FId: Integer;
    FValue: Double;
  published
    [AutoGenerated]
    property Id: Integer read FId write FId;
    property Value: Double read FValue write FValue;
  end;

  [Entity]
  TClassWithCascadeAttribute = class
  private
    FUpdateCascade: TClassWithCascadeForeignClass;
    FInsertCascade: TClassWithCascadeForeignClass;
    FUpdateInsertCascade: TClassWithCascadeForeignClass;
    FId: Integer;
  published
    property Id: Integer read FId write FId;
    [InsertCascade]
    property InsertCascade: TClassWithCascadeForeignClass read FInsertCascade write FInsertCascade;
    [UpdateCascade]
    property UpdateCascade: TClassWithCascadeForeignClass read FUpdateCascade write FUpdateCascade;
    [InsertCascade, UpdateCascade]
    property UpdateInsertCascade: TClassWithCascadeForeignClass read FUpdateInsertCascade write FUpdateInsertCascade;
  end;

  TManyValueParentSelfReference = class;

  [Entity]
  TManyValueParentSelfReferenceChild = class
  private
    FChild: TManyValueParentSelfReference;
    FId: Integer;
    FParent: TManyValueParentSelfReference;
  published
    property Child: TManyValueParentSelfReference read FChild write FChild;
    property Id: Integer read FId write FId;
    property Parent: TManyValueParentSelfReference read FParent write FParent;
  end;

  [Entity]
  TManyValueParentSelfReference = class
  private
    FChilds: TArray<TManyValueParentSelfReferenceChild>;
    FId: Integer;
  published
    [ManyValueAssociationLinkName('Parent')]
    property Childs: TArray<TManyValueParentSelfReferenceChild> read FChilds write FChilds;
    property Id: Integer read FId write FId;
  end;

  TManyValueParentWithoutPrimaryKey = class;

  TManyValueParentWithoutPrimaryKeyChild = class
  private
    FManyValueParentWithoutPrimaryKey: TManyValueParentWithoutPrimaryKey;
  published
    property ManyValueParentWithoutPrimaryKey: TManyValueParentWithoutPrimaryKey read FManyValueParentWithoutPrimaryKey write FManyValueParentWithoutPrimaryKey;
  end;

  TManyValueParentWithoutPrimaryKey = class
  private
    FId: String;
    FChild: TArray<TManyValueParentWithoutPrimaryKeyChild>;
  published
    property Child: TArray<TManyValueParentWithoutPrimaryKeyChild> read FChild write FChild;
    property Id: String read FId write FId;
  end;

  TManyValueClassBase = class;

  [Entity]
  TManyValueClassBaseChild = class
  private
    FManyValueClassBase: TManyValueClassBase;
    FId: Integer;
  published
    property Id: Integer read FId write FId;
    property ManyValueClassBase: TManyValueClassBase read FManyValueClassBase write FManyValueClassBase;
  end;

  [Entity]
  TManyValueClassBase = class
  private
    FValues: TArray<TManyValueClassBaseChild>;
    FId: Integer;
  published
    property Id: Integer read FId write FId;
    property Values: TArray<TManyValueClassBaseChild> read FValues write FValues;
  end;

  TManyValueClassInherited = class;

  [Entity]
  TManyValueClassInheritedChild = class
  private
    FManyValueClassInherited: TManyValueClassInherited;
    FId: Integer;
  published
    property Id: Integer read FId write FId;
    property ManyValueClassInherited: TManyValueClassInherited read FManyValueClassInherited write FManyValueClassInherited;
  end;

  [Entity]
  TManyValueClassInherited = class(TManyValueClassBase)
  private
    FAnotherValues: TArray<TManyValueClassInheritedChild>;
  published
    property AnotherValues: TArray<TManyValueClassInheritedChild> read FAnotherValues write FAnotherValues;
  end;

  [Entity]
  TMyClassWithForeignKeyBase = class
  private
    FMyField: TManyValueClassInherited;
    FId: Integer;
  published
    property Id: Integer read FId write FId;
    property MyField: TManyValueClassInherited read FMyField write FMyField;
  end;

  [Entity]
  TMyClassWithForeignKeyInherited = class(TMyClassWithForeignKeyBase)
  private
    FValue: String;
  published
    property Value: String read FValue write FValue;
  end;

  [Entity]
  TClassWithNoUpdateAttribute = class
  private
    FId: String;
    FNoUpdate: String;
    FValue: String;
  published
    property Id: String read FId write FId;
    [NoUpdate]
    property NoUpdate: String read FNoUpdate write FNoUpdate;
    property Value: String read FValue write FValue;
  end;

  [Entity]
  TLazyFilterClass = class
  private
    FMany: TManyValueParent;
    FId: Integer;
  published
    property Id: Integer read FId write FId;
    property Many: TManyValueParent read FMany write FMany;
  end;

  [Entity]
  TFilterClass = class
  private
    FLazyFilterClass: Lazy<TLazyFilterClass>;
    FId: Integer;
  published
    property Id: Integer read FId write FId;
    property LazyFilterClass: Lazy<TLazyFilterClass> read FLazyFilterClass write FLazyFilterClass;
  end;

implementation

uses System.SysUtils;

{ TManyValueParentChildError }

function TManyValueParentChildError.GetParent: TManyValueParentError;
begin
  Result := FParent;

  if Assigned(FParent) and (FPassCount >= FParent.PassCount) then
    raise Exception.Create('Can not access this property!');

  Inc(FPassCount);
end;

end.

