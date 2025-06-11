namespace PieterKok.ALCodeExperiments;

page 50207 "Target Table List PTE"
{
    ApplicationArea = All;
    Caption = 'Target Table List';
    PageType = List;
    SourceTable = "Target Table PTE";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
            }
        }
    }
}
