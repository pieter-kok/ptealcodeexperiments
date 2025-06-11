namespace PieterKok.ALCodeExperiments;

using Microsoft.Foundation.Reporting;

codeunit 50200 "ReportManagement Subscr. PTE"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnAfterSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    var
        ReportSubstitution: Record "Report Substitution PTE";
    begin
        if not ReportSubstitution.Get(ReportId) then
            exit;

        if ReportSubstitution."New Report ID" = 0 then
            exit;

        NewReportId := ReportSubstitution."New Report ID";
    end;
}
