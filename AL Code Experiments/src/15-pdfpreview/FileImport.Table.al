namespace PieterKok.ALCodeExperiments;

table 50207 "File Import PTE"
{
    Caption = 'File Import';
    DataClassification = CustomerContent;
    DrillDownPageId = "File Import PTE";
    LookupPageId = "File Import PTE";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            ToolTip = 'Specifies the entry number of the file import record.';
        }
        field(10; "File BLOB"; Blob)
        {
            Caption = 'File BLOB';
            ToolTip = 'Specifies the file content as a BLOB.';
        }
        field(20; "File Name"; Text[2048])
        {
            Caption = 'File Name';
            ToolTip = 'Specifies the name of the file.';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Entry No.", "File Name") { }
        fieldgroup(DropDown; "Entry No.", "File Name") { }
    }

    var
        FileImportHelper: Codeunit "File Import Helper PTE";

    internal procedure PreviewFile()
    begin
        FileImportHelper.PreviewFile(Rec);
    end;

    internal procedure DownloadFile()
    begin
        FileImportHelper.DownloadFile(Rec);
    end;
}