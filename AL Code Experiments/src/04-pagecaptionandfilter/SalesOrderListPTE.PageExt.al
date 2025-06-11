namespace PieterKok.ALCodeExperiments;

using Microsoft.Sales.Document;

pageextension 50200 "Sales Order List PTE" extends "Sales Order List"
{
    Caption = 'Sales Line List';

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Document Type");
    end;
}
