page 50204 "Hierarchy Descr. PTE"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Hierarchy Descriptions';
    PageType = List;
    SourceTable = "Hierarchy Descr. PTE";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a code.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description.';
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ToolTip = 'Specifies the level for the hierarchy.';
                    ApplicationArea = All;
                }
                field(Style; Rec.Style)
                {
                    ToolTip = 'Specifies the style.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
