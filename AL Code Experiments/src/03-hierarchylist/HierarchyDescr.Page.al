namespace PieterKok.ALCodeExperiments;

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
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a code.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description.';
                }
                field(Level; Rec.Level)
                {
                    ToolTip = 'Specifies the level for the hierarchy.';
                }
                field(Style; Rec.Style)
                {
                    ToolTip = 'Specifies the style.';
                }
            }
        }
    }

}
