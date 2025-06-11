namespace PieterKok.ALCodeExperiments;

page 50208 "Contract List PTE"
{
    AdditionalSearchTerms = 'Contract List';
    ApplicationArea = All;
    Caption = 'Contracts';
    CardPageId = "Contract Card PTE";
    PageType = List;
    SourceTable = "Contract PTE";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
