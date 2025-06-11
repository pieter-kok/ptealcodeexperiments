namespace PieterKok.ALCodeExperiments;

page 50210 "Contract Card PTE"
{
    ApplicationArea = All;
    Caption = 'Contract Card';
    PageType = Card;
    SourceTable = "Contract PTE";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
            }
        }
    }
}
