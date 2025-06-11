namespace PieterKok.ALCodeExperiments;
using System.Text;

codeunit 50210 "Unbound Actions PTE"
{
    procedure StoreInputFromJson(InputJson: JsonObject; ErrorText: Text): Boolean
    begin
        ProcessActionMessage(InputJson);
    end;

    procedure StoreInputFromText(InputText: Text; ErrorText: Text): Boolean
    var
        InputJson: JsonObject;
    begin
        InputJson.ReadFrom(InputText);
        ProcessActionMessage(InputJson);
    end;

    procedure StoreInputFromBase64(InputBase64: Text; ErrorText: Text): Boolean
    var
        Base64Convert: Codeunit "Base64 Convert";
        InputJson: JsonObject;
        InputText: Text;
    begin
        InputText := Base64Convert.FromBase64(InputText);
        InputJson.ReadFrom(InputText);
        ProcessActionMessage(InputJson);
    end;

    local procedure ProcessActionMessage(InputJson: JsonObject)
    var
        ActionMessageLog: Record "Action Message Log PTE";
        ProcessActMessageMeth: Codeunit "Process Act. Message Meth PTE";
    begin
        Clear(ActionMessageLog);

        ProcessActMessageMeth.SetInputJson(InputJson);
        if ProcessActMessageMeth.Run(ActionMessageLog) then
            exit;

        if ActionMessageLog."Entry No." = 0 then
            ActionMessageLog.Create();

        ActionMessageLog."Error Text" := CopyStr(GetLastErrorText, 1, MaxStrLen(ActionMessageLog."Error Text"));
        ActionMessageLog.Modify(true);
    end;
}