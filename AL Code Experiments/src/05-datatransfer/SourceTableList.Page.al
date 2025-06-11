namespace PieterKok.ALCodeExperiments;

page 50206 "Source Table List PTE"
{
    ApplicationArea = All;
    Caption = 'Source Table List';
    PageType = List;
    SourceTable = "Source Table PTE";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
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
