table 50200 "Report Substitution PTE"
{
    Caption = 'Report Substitution';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Report Substitutions PTE";
    LookupPageId = "Report Substitutions PTE";

    fields
    {
        field(1; "Original Report ID"; Integer)
        {
            Caption = 'Original Report ID';
            BlankZero = true;
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(10; "Original Report Caption"; Text[249])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report), "Object ID" = field("Original Report ID")));
            Caption = 'Original Report Caption';
            FieldClass = FlowField;
        }
        field(20; "New Report ID"; Integer)
        {
            Caption = 'New Report ID';
            BlankZero = true;
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(30; "New Report Caption"; Text[249])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report), "Object ID" = field("New Report ID")));
            Caption = 'New Report Caption';
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "Original Report ID")
        {
            Clustered = true;
        }
    }

}
