pageextension 50204 "Company Information PTE" extends "Company Information"
{
    layout
    {
        addlast(General)
        {
            field("CurrentClientTypePTE PTE"; Format(CurrentClientType))
            {
                ApplicationArea = All;
                Caption = 'Current Client Type';
                Editable = false;
                ToolTip = 'Shows the client type for the current user.';
            }
        }
    }
}