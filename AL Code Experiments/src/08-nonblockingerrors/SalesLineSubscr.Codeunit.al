namespace PieterKok.ALCodeExperiments;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;

codeunit 50205 "Sales Line Subscr. PTE"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItem(var SalesLine: Record "Sales Line")
    begin
        ReplaceItemDescription(SalesLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateUnitOfMeasureCodeOnAfterGetItemData', '', false, false)]
    local procedure OnValidateUnitOfMeasureCodeOnAfterGetItemData(var SalesLine: Record "Sales Line")
    begin
        ReplaceItemDescription(SalesLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateItemReference', '', false, false)]
    local procedure OnAfterUpdateItemReference(var SalesLine: Record "Sales Line")
    begin
        ReplaceItemDescription(SalesLine);
    end;



    local procedure ReplaceItemDescription(var SalesLine: Record "Sales Line")
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        CurrRecordRef: RecordRef;
        ErrInfo: ErrorInfo;
        ItemDescriptionCannotBeConstructedErr: Label 'The item description cannot be constructed. %1 is missing in %2.', Comment = '%1=Field caption, %2=Table caption';
        OpenSetupLbl: Label 'Open setup';
        OpenSetupTooltipLbl: Label 'Opens the setup to fill the missing field.';
    begin
        SalesReceivablesSetup.Get();
        if SalesReceivablesSetup."Item Description Setup PTE" = '' then begin
            CurrRecordRef.GetTable(SalesLine);
            ErrInfo.ErrorType(ErrorType::Client);
            ErrInfo.Verbosity(Verbosity::Error);
            ErrInfo.Message(StrSubstNo(ItemDescriptionCannotBeConstructedErr, SalesReceivablesSetup.FieldCaption("Item Description Setup PTE"), SalesReceivablesSetup.TableCaption()));
            ErrInfo.RecordId(CurrRecordRef.RecordId);
            ErrInfo.AddAction(OpenSetupLbl, Codeunit::"Open Setup PTE", 'OpenSetup', OpenSetupTooltipLbl);
            Error(ErrInfo);
        end;

        SalesLine.Description := StrSubstNo(SalesReceivablesSetup."Item Description Setup PTE", SalesLine.Description);
    end;
}
