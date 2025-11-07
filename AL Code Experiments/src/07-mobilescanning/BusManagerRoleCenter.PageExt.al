namespace PieterKok.ALCodeExperiments;

using Microsoft.Finance.RoleCenters;

pageextension 50201 "Bus. Manager Role Center PTE" extends "Business Manager Role Center"
{
    actions
    {
        addlast(embedding)
        {
            action("MobileScan PTE")
            {
                ApplicationArea = All;
                Caption = 'Mobile Scan';
                ToolTip = 'Opens the Mobile Scan page.';
                RunObject = page "Mobile Scan PTE";
            }
        }
    }
}