namespace PieterKok.ALCodeExperiments;

codeunit 50211 "Process Act. Message Meth PTE"
{
    TableNo = "Action Message Log PTE";

    var
        InputJson: JsonObject;

    trigger OnRun()
    begin
        ProcessActionMessage(Rec, InputJson);
    end;

    internal procedure ProcessActionMessage(var ActionMessageLog: Record "Action Message Log PTE"; RequestJson: JsonObject)
    var
        IsHandled: Boolean;
    begin
        OnBeforeProcessActionMessage(ActionMessageLog, RequestJson, IsHandled);
        DoProcessActionMessage(ActionMessageLog, RequestJson, IsHandled);
        OnAfterProcessActionMessage(ActionMessageLog, RequestJson);
    end;

    internal procedure SetInputJson(Json: JsonObject)
    begin
        InputJson := Json;
    end;

    local procedure DoProcessActionMessage(var ActionMessageLog: Record "Action Message Log PTE"; RequestJson: JsonObject; IsHandled: Boolean)
    begin
        if IsHandled then
            exit;

        CreateActionMessageLog(ActionMessageLog);
        Commit();
        StoreInputJson(ActionMessageLog, RequestJson);
        Commit();
    end;

    local procedure CreateActionMessageLog(var ActionMessageLog: Record "Action Message Log PTE")
    begin
        Clear(ActionMessageLog);
        ActionMessageLog.Create();
    end;

    local procedure StoreInputJson(var ActionMessageLog: Record "Action Message Log PTE"; RequestJson: JsonObject)
    begin
        ActionMessageLog.AddRequest(RequestJson);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeProcessActionMessage(var ActionMessageLog: Record "Action Message Log PTE"; RequestJson: JsonObject; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterProcessActionMessage(var ActionMessageLog: Record "Action Message Log PTE"; RequestJson: JsonObject)
    begin
    end;
}