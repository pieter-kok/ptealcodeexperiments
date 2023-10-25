page 50208 "Contract List PTE"
{
    ApplicationArea = All;
    AdditionalSearchTerms = 'Contract List';
    Caption = 'Contracts';
    CardPageId = "Contract Card PTE";
    PageType = List;
    SourceTable = "Contract PTE";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
            }
        }
    }
}
