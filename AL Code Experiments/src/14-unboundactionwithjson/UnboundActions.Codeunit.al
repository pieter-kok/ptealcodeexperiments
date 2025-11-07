namespace PieterKok.ALCodeExperiments;
using System.Text;

codeunit 50210 "Unbound Actions PTE"
{
    procedure storeInputFromJson(inputJson: JsonToken) value: JsonToken
    var
        ErrorText: Text;
    begin
        ProcessActionMessage(inputJson, ErrorText);
        CreateJsonObjectResponse(value, ErrorText)
    end;

    procedure storeInputFromText(inputText: Text) value: Text
    var
        InputJson, ResultJsonToken : JsonToken;
        ErrorText: Text;
    begin
        InputJson.ReadFrom(inputText);
        ProcessActionMessage(inputJson, value);
        CreateJsonObjectResponse(ResultJsonToken, ErrorText);
        ResultJsonToken.WriteTo(value);
    end;

    procedure storeInputFromBase64(inputBase64: Text) value: Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        InputJson: JsonToken;
        ErrorText, InputText : Text;
    begin
        InputText := Base64Convert.FromBase64(inputBase64);
        InputJson.ReadFrom(inputText);
        ProcessActionMessage(inputJson, ErrorText);
        CreateBase64Response(value, ErrorText)
    end;

    local procedure ProcessActionMessage(InputJson: JsonToken; var ErrorText: Text)
    var
        ActionMessageLog: Record "Action Message Log PTE";
        ProcessActMessageMeth: Codeunit "Process Act. Message Meth PTE";
    begin
        Clear(ActionMessageLog);
        Clear(ErrorText);

        ProcessActMessageMeth.SetInputJson(InputJson);
        if ProcessActMessageMeth.Run(ActionMessageLog) then
            exit;

        if ActionMessageLog."Entry No." = 0 then
            ActionMessageLog.Create();

        ActionMessageLog."Error Text" := CopyStr(GetLastErrorText, 1, MaxStrLen(ActionMessageLog."Error Text"));
        ActionMessageLog.Modify(true);

        ErrorText := ActionMessageLog."Error Text";
    end;

    local procedure CreateJsonObjectResponse(var ResultJsonToken: JsonToken; ErrorText: Text)
    var
        ResultObject: JsonObject;
        ErrorTextTok: Label 'errorText', Locked = true;
        ErrorTok: Label 'Error', Locked = true;
        OKTok: Label 'OK', Locked = true;
        StatusTok: Label 'status', Locked = true;
    begin
        if ErrorText = '' then
            ResultObject.Add(StatusTok, OKTok)
        else begin
            ResultObject.Add(StatusTok, ErrorTok);
            ResultObject.Add(ErrorTextTok, ErrorText);
        end;

        ResultJsonToken := ResultObject.AsToken();
    end;

    local procedure CreateBase64Response(var ResultValue: Text; ErrorText: Text)
    var
        Base64Convert: Codeunit "Base64 Convert";
        ResultJsonToken: JsonToken;
    begin
        CreateJsonObjectResponse(ResultJsonToken, ErrorText);
        ResultJsonToken.WriteTo(ResultValue);
        ResultValue := Base64Convert.ToBase64(ResultValue);
    end;
}