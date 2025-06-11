namespace PieterKok.ALCodeExperiments;

codeunit 50212 "Action Message Log Helper PTE"
{
    internal procedure Create(var ActionMessageLog: Record "Action Message Log PTE")
    var
        LastActionMessageLog: Record "Action Message Log PTE";
        NextLineNo: Integer;
    begin
        LastActionMessageLog.ReadIsolation := IsolationLevel::UpdLock;
        if not LastActionMessageLog.FindLast() then
            Clear(LastActionMessageLog);

        NextLineNo := LastActionMessageLog."Entry No." + 1;

        ActionMessageLog.Init();
        ActionMessageLog."Entry No." := NextLineNo;
        ActionMessageLog.Insert(true);
    end;

    internal procedure AddRequest(var ActionMessageLog: Record "Action Message Log PTE"; RequestJson: JsonObject)
    var
        JsonOutStream: OutStream;
    begin
        ActionMessageLog.TestField("Entry No.");

        ActionMessageLog.Request.CreateOutStream(JsonOutStream);
        RequestJson.WriteTo(JsonOutStream);
        ActionMessageLog.Modify(true);
    end;
}