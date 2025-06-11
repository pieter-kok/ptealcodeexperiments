namespace PieterKok.ALCodeExperiments;

using Microsoft.Foundation.Reporting;
using Microsoft.Projects.Project.Reports;

page 50200 "Report Substitutions PTE"
{
    ApplicationArea = All;
    Caption = 'Report Substitutions';
    PageType = List;
    SourceTable = "Report Substitution PTE";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Original Report ID"; Rec."Original Report ID")
                {
                    ToolTip = 'Specifies the original report id.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Original Report Caption"; Rec."Original Report Caption")
                {
                    ToolTip = 'Specifies the caption of the original report.';
                }
                field("New Report ID"; Rec."New Report ID")
                {
                    ToolTip = 'Specifies the value the new report id.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("New Report Caption"; Rec."New Report Caption")
                {
                    ToolTip = 'Specifies the caption of the new report.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(InitJobQuoteReport)
            {
                Caption = 'Init Job Quote Report';
                Image = Report;
                ToolTip = 'Initializes the job quote report in report selections.';

                trigger OnAction()
                var
                    ReportSelections: Record "Report Selections";
                begin
                    ReportSelections.SetRange(Usage, ReportSelections.Usage::JQ);
                    ReportSelections.SetFilter("Report ID", '<>%1', 0);
                    if not ReportSelections.IsEmpty then
                        exit;

                    ReportSelections.Init();
                    ReportSelections.Validate(Usage, ReportSelections.Usage::JQ);
                    ReportSelections.Validate(Sequence, '0');
                    ReportSelections.Validate("Report ID", Report::"Job Quote");
                    ReportSelections.Insert();
                end;
            }
        }

    }
}