pageextension 50202 "Sales & Receivables Setup PTE" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Item Description Setup PTE"; Rec."Item Description Setup PTE")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the setup of the Item Description in the Sales Line. %1=Original value';
            }

        }
    }
}
