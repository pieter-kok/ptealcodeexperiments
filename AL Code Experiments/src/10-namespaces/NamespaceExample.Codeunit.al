namespace Bluace.Demo.Namespaces;

using Microsoft.Sales.Document;

codeunit 50207 "Namespace Example PTE"
{
    trigger OnRun()
    var
        Customer: Record Microsoft.Sales.Customer.Customer;
        SalesHeader: Record "Sales Header";
    begin
        if Customer.FindFirst() then begin
            SalesHeader.Init();
            SalesHeader.Validate("Document Type", "Sales Document Type"::Order);
            SalesHeader.InitRecord();
            SalesHeader.Insert(true);

            SalesHeader.Validate("Sell-to Customer No.", Customer."No.");
            SalesHeader.Modify(true);

            Commit();

            Page.RunModal(Page::"Sales Order", SalesHeader);
        end;
    end;
}
