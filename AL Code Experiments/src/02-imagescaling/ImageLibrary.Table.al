namespace PieterKok.ALCodeExperiments;

using System.Utilities;

table 50201 "Image Library PTE"
{
    DataCaptionFields = "Entry No.", Description;
    DataClassification = CustomerContent;
    DrillDownPageId = "Image Library List PTE";
    LookupPageId = "Image Library List PTE";

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            Editable = false;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(20; "Source Image"; Media)
        {
            Caption = 'Source Image';
        }
        field(30; "Source Base64"; Blob)
        {
            Caption = 'Source Base64';
        }
        field(32; "Source Height"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Height';
            Editable = false;
        }
        field(34; "Source Width"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Width';
            Editable = false;
        }
        field(36; "Source Format"; Enum "Image Format")
        {
            Caption = 'Source Format';
            Editable = false;
        }
        field(38; "Source Format Text"; Text[100])
        {
            Caption = 'Source Format Text';
            Editable = false;
        }
        field(40; "Target Image"; Media)
        {
            Caption = 'Target Image';
        }
        field(50; "Target Base64"; Blob)
        {
            Caption = 'Target Base64';
        }
        field(52; "Target Height"; Integer)
        {
            BlankZero = true;
            Caption = 'Target Height';
            Editable = false;
        }
        field(54; "Target Width"; Integer)
        {
            BlankZero = true;
            Caption = 'Target Width';
            Editable = false;
        }
        field(56; "Target Format"; Enum "Image Format")
        {
            Caption = 'Target Format';
            Editable = false;
        }
        field(58; "Target Format Text"; Text[100])
        {
            Caption = 'Target Format Text';
            Editable = false;
        }
        field(60; "Crop X"; Integer)
        {
            Caption = 'Crop X';
        }
        field(70; "Crop Y"; Integer)
        {
            Caption = 'Crop Y';
        }
        field(80; Height; Integer)
        {
            Caption = 'Height';
        }
        field(90; Width; Integer)
        {
            Caption = 'Width';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        ImageLibraryHelper: Codeunit "Image Library Helper PTE";

    procedure ImportImage(CalledFromFieldNo: Integer)
    begin
        ImageLibraryHelper.ImportImage(Rec, CalledFromFieldNo);
    end;

    procedure DeleteImage(CalledFromFieldNo: Integer)
    begin
        ImageLibraryHelper.DeleteImage(Rec, CalledFromFieldNo);
    end;

    procedure ExportImageFromMedia(CalledFromFieldNo: Integer)
    begin
        ImageLibraryHelper.ExportImageFromMedia(Rec, CalledFromFieldNo);
    end;

    procedure ExportBase64(CalledFromFieldNo: Integer)
    begin
        ImageLibraryHelper.ExportBase64(Rec, CalledFromFieldNo);
    end;

    procedure SaveTargetImage(var Image: Codeunit Image)
    begin
        ImageLibraryHelper.SaveTargetImage(Rec, Image);
    end;

    procedure CropImage()
    begin
        ImageLibraryHelper.CropImage(Rec);
    end;

    procedure ResizeImage()
    begin
        ImageLibraryHelper.ResizeImage(Rec);
    end;

    procedure PrintImageLibrary()
    begin
        ImageLibraryHelper.PrintImageLibrary(Rec);
    end;
}