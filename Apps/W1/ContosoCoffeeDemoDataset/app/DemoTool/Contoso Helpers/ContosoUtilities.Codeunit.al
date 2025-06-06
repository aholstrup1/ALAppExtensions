// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.DemoTool.Helpers;

using Microsoft.DemoTool;
using System.Utilities;
using System.Text;
using System.Environment;

codeunit 5142 "Contoso Utilities"
{
    InherentEntitlements = X;
    InherentPermissions = X;

    internal procedure AdjustPrice(UnitPrice: Decimal): Decimal
    var
        ContosoCoffeeDemoDataSetup: Record "Contoso Coffee Demo Data Setup";
    begin
        ContosoCoffeeDemoDataSetup.Get();

        if UnitPrice = 0 then
            exit(0);

        exit(Round(UnitPrice * ContosoCoffeeDemoDataSetup."Price Factor", ContosoCoffeeDemoDataSetup."Rounding Precision"));
    end;

    procedure AdjustDate(OriginalDate: Date): Date
    var
        ContosoCoffeeDemoDataSetup: Record "Contoso Coffee Demo Data Setup";
        TempDate: Date;
        WeekDay: Integer;
        MonthDay: Integer;
        Week: Integer;
        Month: Integer;
        Year: Integer;
    begin
        ContosoCoffeeDemoDataSetup.Get();

        if OriginalDate <> 0D then begin
            TempDate := CalcDate('<+92Y>', OriginalDate);
            WeekDay := Date2DWY(TempDate, 1);
            MonthDay := Date2DMY(TempDate, 1);
            Month := Date2DMY(TempDate, 2);
            Week := Date2DWY(TempDate, 2);
            Year := Date2DMY(TempDate, 3) + ContosoCoffeeDemoDataSetup."Starting Year" - 1994;
            case Month of
                1, 3, 5, 7, 8, 10, 12:
                    if (MonthDay = 31) or (MonthDay = 1) then
                        exit(DMY2Date(MonthDay, Month, Year));
                2:
                    if (MonthDay = 28) or (MonthDay = 1) then
                        exit(DMY2Date(MonthDay, Month, Year));
                4, 6, 9, 11:
                    if (MonthDay = 30) or (MonthDay = 1) then
                        exit(DMY2Date(MonthDay, Month, Year));
            end;

            exit(DWY2Date(WeekDay, Week, Year))
        end;

        exit(0D);
    end;

    procedure GetFileStream(var TempBlob: Codeunit "Temp Blob"; FileBase64: Text)
    var
        Base64Convert: Codeunit "Base64 Convert";
        ObjOutStream: OutStream;
    begin
        TempBlob.CreateOutStream(ObjOutStream);
        Base64Convert.FromBase64(FileBase64, ObjOutStream);
    end;

    procedure EmptyPicture(): Codeunit "Temp Blob"
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        exit(TempBlob);
    end;

    internal procedure RandBarcodeInt(): Integer
    begin
        exit(10000000 - 1 + Random(99999999 - 10000000 + 1));
    end;

    var
        DefaultBatchNameLbl: Label 'DEFAULT', MaxLength = 10;

    procedure GetDefaultBatchNameLbl(): Code[10]
    begin
        exit(DefaultBatchNameLbl);
    end;

    procedure GetTempBlobFromFile(FilePath: Text) result: Codeunit "Temp Blob"
    var
        ObjInStream: InStream;
        OutStr: OutStream;
    begin
        NavApp.GetResource(FilePath, ObjInStream);
        result.CreateOutStream(OutStr);
        CopyStream(OutStr, ObjInStream);
    end;

    [Scope('OnPrem')]
    procedure InsertBLOBFromFile(FilePath: Text; FileName: Text): Code[50]
    var
        MediaResources: Record "Media Resources";
        BLOBInStream: InStream;
        BLOBOutStream: OutStream;
        MediaResourceCode: Code[50];
    begin
        MediaResourceCode := CopyStr(FileName, 1, MaxStrLen(MediaResourceCode));
        if MediaResources.Get(MediaResourceCode) then
            exit;

        NavApp.GetResource(FilePath + FileName, BLOBInStream);

        MediaResources.Init();
        MediaResources.Validate(Code, MediaResourceCode);
        MediaResources.Blob.CreateOutStream(BLOBOutStream);
        CopyStream(BLOBOutStream, BLOBInStream);

#pragma warning disable AS0059
        MediaResources.Insert(true);
#pragma warning restore AS0059
        exit(MediaResourceCode);
    end;
}
