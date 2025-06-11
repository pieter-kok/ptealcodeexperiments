namespace PieterKok.ALCodeExperiments;

table 50202 "Hierarchy Descr. PTE"
{
    Caption = 'Hierarchy Description';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(20; Level; Integer)
        {
            Caption = 'Level';
        }
        field(30; Style; Enum "Hierarchy Style PTE")
        {
            Caption = 'Style';
        }

    }
    keys
    {
        key(PK; Code, "Line No.")
        {
            Clustered = true;
        }
    }

    var
        HierarchyDescrHelper: Codeunit "Hierarchy Descr. Helper PTE";

    procedure GetStyleExpr(): Text
    begin
        exit(HierarchyDescrHelper.GetStyleExpr(Rec));
    end;
}
