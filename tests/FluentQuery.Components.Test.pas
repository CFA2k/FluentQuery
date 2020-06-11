{****************************************************}
{                                                    }
{  FluentQuery                                       }
{                                                    }
{  Copyright (C) 2013 Malcolm Groves                 }
{                                                    }
{  http://www.malcolmgroves.com                      }
{                                                    }
{****************************************************}
{                                                    }
{  This Source Code Form is subject to the terms of  }
{  the Mozilla Public License, v. 2.0. If a copy of  }
{  the MPL was not distributed with this file, You   }
{  can obtain one at                                 }
{                                                    }
{  http://mozilla.org/MPL/2.0/                       }
{                                                    }
{****************************************************}
unit FluentQuery.Components.Test;

interface
uses
  TestFramework,
  FluentQuery.Components,
  FluentQuery.Components.Test.Form,
  FluentQuery.Components.Test.DataModule;


type
  TestTQueryComponent = class(TTestCase)
  private
    FTestForm : TFQComponentTestForm;
    FTestDataModule : TFQComponentTestDataModule;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPassThrough;
    procedure TestVisual;
    procedure TestNonVisual;
    procedure TestNonExistant;
    procedure TestTag;
    procedure TestTagNotFound;
    procedure TestHasPropertyColor;
    procedure TestHasTagEquals1;
    procedure TestHasTagGreaterThanZero;
    procedure TestHasCaptionEqualsHello;
    procedure TestHasCaptionStartingWithHel;
    procedure TestIsAWinControlHasEnabledFalse;
    procedure TestIsAWinControlHasEnabledFalseAlternative;
    procedure TestNameStartsWithString;
    procedure TestNameIs;
    procedure TestTagGreaterThanZero;
    procedure TestEnabled;
    procedure TestDisabled;
    procedure TestActive;
    procedure TestInactive;
  end;



implementation
uses System.Classes, VCL.StdCtrls, Vcl.ExtCtrls, System.TypInfo, VCL.Controls,
     FluentQuery.Integers, FluentQuery.Strings;

{ TestTQueryComponent }

procedure TestTQueryComponent.SetUp;
begin
  inherited;
  FTestForm := TFQComponentTestForm.Create(nil);
  FTestDataModule := TFQComponentTestDataModule.Create(nil);
end;

procedure TestTQueryComponent.TearDown;
begin
  inherited;
  FTestForm.Free;
  FTestDataModule.Free;
end;

procedure TestTQueryComponent.TestNonVisual;
begin
  CheckEquals(1, ComponentQuery<TTimer>.Select.From(FTestForm).Count);
end;

procedure TestTQueryComponent.TestVisual;
begin
  CheckEquals(4, ComponentQuery<TEdit>.Select.From(FTestForm).Count);
end;

procedure TestTQueryComponent.TestHasPropertyColor;
begin
  CheckEquals(6, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .HasProperty('Color', tkInteger)
                  .Count);
end;

procedure TestTQueryComponent.TestHasTagEquals1;
begin
  CheckEquals(4, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .IntegerProperty('Tag', 1)
                  .Count);
end;

procedure TestTQueryComponent.TestHasTagGreaterThanZero;
begin
  CheckEquals(5, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .IntegerProperty('Tag', IntegerQuery.GreaterThan(0))
                  .Count);
end;

procedure TestTQueryComponent.TestInactive;
begin
  CheckEquals(2, ComponentQuery<TComponent>
                  .Select
                  .From(FTestDataModule)
                  .Inactive
                  .Count);
end;

procedure TestTQueryComponent.TestIsAWinControlHasEnabledFalse;
begin
  CheckEquals(2, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .IsA(TWinControl)
                  .BooleanProperty('Enabled', False)
                  .Count);
end;

procedure TestTQueryComponent.TestIsAWinControlHasEnabledFalseAlternative;
begin
  CheckEquals(2, ComponentQuery<TWinControl>
                  .Select
                  .From(FTestForm)
                  .BooleanProperty('Enabled', False)
                  .Count);
end;

procedure TestTQueryComponent.TestActive;
begin
  CheckEquals(0, ComponentQuery<TComponent>
                  .Select
                  .From(FTestDataModule)
                  .Active
                  .Count);
end;

procedure TestTQueryComponent.TestDisabled;
begin
  CheckEquals(3, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .Disabled
                  .Count);
end;

procedure TestTQueryComponent.TestEnabled;
begin
  CheckEquals(6, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .Enabled
                  .Count);
end;

procedure TestTQueryComponent.TestHasCaptionEqualsHello;
begin
  CheckEquals(2, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .StringProperty('Caption', 'HeLLo')
                  .Count);
end;

procedure TestTQueryComponent.TestHasCaptionStartingWithHel;
begin
  CheckEquals(2, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .StringProperty('Caption', StringQuery.StartsWith('HEL'))
                  .Count);
end;

procedure TestTQueryComponent.TestNameIs;
begin
  CheckEquals(1, ComponentQuery<TComponent>
                    .Select
                    .From(FTestForm)
                    .Name('Button1')
                    .Count);
end;

procedure TestTQueryComponent.TestNameStartsWithString;
begin
  CheckEquals(2, ComponentQuery<TComponent>
                    .Select
                    .From(FTestForm)
                    .Name(StringQuery.StartsWith('Butt'))
                    .Count);
end;

procedure TestTQueryComponent.TestNonExistant;
begin
  CheckEquals(0, ComponentQuery<TMemo>.Select.From(FTestForm).Count);
end;

procedure TestTQueryComponent.TestPassThrough;
begin
  CheckEquals(FTestForm.ComponentCount, ComponentQuery<TComponent>.Select.From(FTestForm).Count);
end;

procedure TestTQueryComponent.TestTag;
begin
  CheckEquals(4, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .Tag(1)
                  .Count);
end;

procedure TestTQueryComponent.TestTagNotFound;
begin
  CheckEquals(0, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .Tag(32)
                  .Count);
end;


procedure TestTQueryComponent.TestTagGreaterThanZero;
begin
  CheckEquals(5, ComponentQuery<TComponent>
                  .Select
                  .From(FTestForm)
                  .Tag(IntegerQuery.GreaterThan(0))
                  .Count);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest('Components', TestTQueryComponent.Suite);

end.
