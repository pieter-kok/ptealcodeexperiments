namespace PieterKok.ALCodeExperiments;

using Microsoft.Foundation.Reporting;
using Microsoft.Purchases.Document;
using Microsoft.Shared.Report;
using System.IO;
using System.Reflection;
using System.Utilities;

codeunit 50208 "Generate Purch. Order Doc. PTE"
{
    Permissions =
        tabledata "Purchase Header" = r,
        tabledata "Report Selections" = r;

    procedure SaveDocument(DocumentType: Enum "Purchase Document Type"; DocumentNo: Text[20])
    var
        ReportLayoutList: Record "Report Layout List";
        ReportSelections: Record "Report Selections";
    begin
        case DocumentType of
            DocumentType::Order:
                begin
                    ReportSelections.SetRange(Usage, "Report Selection Usage"::"P.Order");
                    ReportSelections.SetRange("Use for Email Attachment", true);
                    if ReportSelections.FindFirst() then begin
                        GetReportLayoutList(ReportSelections."Report ID", ReportLayoutList);
                        PrintDocumentLayout(ReportSelections."Report ID", ReportLayoutList, DocumentType, DocumentNo);
                    end;
                end;
        end;
    end;

    local procedure GetReportLayoutList(ReportID: Integer; var ReportLayoutList: Record "Report Layout List")
    var
        ReportLayoutNotFoundLbl: Label 'Report layout not found for report ID %1', Comment = '%1=Report ID';

    begin
        ReportLayoutList.SetRange("Report ID", ReportID);
        if ReportLayoutList.IsEmpty() then
            Error(ErrorInfo.Create(StrSubstNo(ReportLayoutNotFoundLbl, ReportID)));

        ReportLayoutList.FindFirst();
        Commit();

        if Page.RunModal(Page::"Report Layouts", ReportLayoutList) <> Action::LookupOK then
            Error('');
    end;


    procedure PrintDocumentLayout(ReportId: Integer; ReportLayoutList: Record "Report Layout List"; DocumentType: Enum "Purchase Document Type"; DocumentNo: Text[20])
    var
        PurchaseHeader: Record "Purchase Header";
        DocumentRecordRef: RecordRef;
        DocumentNotFoundLbl: Label '%1 with %2 ''%3'' not found', Comment = '%1=Document Type, %2=No. FieldCaption, %3=No.', Locked = true;
    begin
        if not PurchaseHeader.Get(DocumentType, DocumentNo) then
            Error(DocumentNotFoundLbl, DocumentType, PurchaseHeader.FieldCaption("No."), DocumentNo);

        PurchaseHeader.SetRecFilter();
        DocumentRecordRef.GetTable(PurchaseHeader);
        GetPrintedDocument(DocumentRecordRef, DocumentType, DocumentNo, ReportId, ReportLayoutList)
    end;

    internal procedure GetPrintedDocument(var DocumentRecordRef: RecordRef; DocumentType: Enum "Purchase Document Type"; DocumentNo: Text[20]; ReportId: Integer; ReportLayoutList: Record "Report Layout List")
    var
        DesignTimeReportSelection: Codeunit "Design-time Report Selection";
        CurrReportFormat: ReportFormat;
        CurrFileName: Text;
    begin
        CurrReportFormat := GetReportFormatFromLayoutFormat(ReportLayoutList."Layout Format");
        CurrFileName := GetFileName(DocumentType, DocumentNo, CurrReportFormat, ReportLayoutList);

        DesignTimeReportSelection.SetSelectedLayout(ReportLayoutList.Name, ReportLayoutList."Application ID"); //This step is using a SingleInstance codeunit, therefore a TryFunction is used
        if TrySaveReport(ReportId, CurrReportFormat, CurrFileName, DocumentRecordRef) then
            DesignTimeReportSelection.ClearLayoutSelection()
        else begin
            DesignTimeReportSelection.ClearLayoutSelection();
            Error(GetLastErrorText());
        end;
    end;


    local procedure GetReportFormatFromLayoutFormat(LayoutFormat: Option RDLC,Word,Excel,Custom) ResultReportFormat: ReportFormat
    begin
        case LayoutFormat of
            LayoutFormat::RDLC:
                exit(ReportFormat::Pdf);
            LayoutFormat::Word:
                exit(ReportFormat::Word);
            LayoutFormat::Excel:
                exit(ReportFormat::Excel);
            else
                OnCustomGetReportFormatFromLayoutFormat(LayoutFormat, ResultReportFormat);
        end;
    end;

    local procedure GetFileName(DocumentType: Enum "Purchase Document Type"; DocumentNo: Text[20]; CurrReportFormat: ReportFormat; ReportLayoutList: Record "Report Layout List") FileName: Text
    var
        FileNameConstructTxt: Label '%1 %2 - %3 %4.%5', Locked = true;
    begin
        case CurrReportFormat of
            CurrReportFormat::Pdf:
                exit(StrSubstNo(FileNameConstructTxt, Format(DocumentType), DocumentNo, ReportLayoutList."Report Name", ReportLayoutList."Application ID", 'pdf'));
            CurrReportFormat::Word:
                exit(StrSubstNo(FileNameConstructTxt, Format(DocumentType), DocumentNo, ReportLayoutList."Report Name", ReportLayoutList."Application ID", 'docx'));
            CurrReportFormat::Excel:
                exit(StrSubstNo(FileNameConstructTxt, Format(DocumentType), DocumentNo, ReportLayoutList."Report Name", ReportLayoutList."Application ID", 'xlsx'));
            else
                OnCustomGetFileName(DocumentType, DocumentNo, CurrReportFormat, ReportLayoutList, FileName);
        end;
    end;

    [TryFunction]
    local procedure TrySaveReport(ReportId: Integer; CurrReportFormat: ReportFormat; FileName: Text; var DocumentRecordRef: RecordRef)
    var
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
    begin
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(ReportId, '', CurrReportFormat, OutStream, DocumentRecordRef);
        TempBlob.CreateInStream(InStream, TextEncoding::Windows);
        FileManagement.BLOBExport(TempBlob, FileName, true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCustomGetReportFormatFromLayoutFormat(LayoutFormat: Option RDLC,Word,Excel,Custom; var ResultReportFormat: ReportFormat)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCustomGetFileName(DocumentType: Enum "Purchase Document Type"; DocumentNo: Text[20]; CurrReportFormat: ReportFormat; ReportLayoutList: Record "Report Layout List"; var FileName: Text)
    begin
    end;
}