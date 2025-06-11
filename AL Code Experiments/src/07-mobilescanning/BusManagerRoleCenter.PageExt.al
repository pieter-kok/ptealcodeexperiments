namespace PieterKok.ALCodeExperiments;

using Microsoft.Finance.RoleCenters;

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
                RunObject = page "Mobile Scan PTE";
            }
        }
    }
}