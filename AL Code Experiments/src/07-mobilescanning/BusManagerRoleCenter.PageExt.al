pageextension 50201 "Bus. Manager Role Center PTE" extends "Business Manager Role Center"
{
    actions
    {
        addlast(embedding)
        {
            action("MobileScanPTE PTE")
            {
                ApplicationArea = All;
                Caption = 'Mobile Scan';
                RunObject = Page "Mobile Scan PTE";
            }
        }
    }
}