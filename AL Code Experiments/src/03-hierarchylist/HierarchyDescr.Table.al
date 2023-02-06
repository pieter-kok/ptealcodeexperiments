table 50202 "Hierarchy Descr. PTE"
{
    Caption = 'Hierarchy Description';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(20; Level; Integer)
        {
            Caption = 'Level';
            DataClassification = CustomerContent;
        }
        field(30; "Style"; enum "Hierarchy Style PTE")
        {
            Caption = 'Style';
            DataClassification = CustomerContent;
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

    procedure GetStyleExpr(): Text;
    begin
        exit(HierarchyDescrHelper.GetStyleExpr(Rec));
    end;
}
