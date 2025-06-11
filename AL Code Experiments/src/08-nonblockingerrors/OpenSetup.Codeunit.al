namespace PieterKok.ALCodeExperiments;

using Microsoft.Sales.Setup;
using Microsoft.Utilities;

codeunit 50206 "Open Setup PTE"
{
    procedure OpenSetup(ErrInfo: ErrorInfo)
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        PageManagement: Codeunit "Page Management";
    begin
        SalesReceivablesSetup.Get();
        PageManagement.PageRun(SalesReceivablesSetup);
    end;
}
