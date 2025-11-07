namespace PieterKok.ALCodeExperiments;

codeunit 50209 "Import File Meth PTE"
{
    internal procedure ImportFile(var FileImport: Record "File Import PTE")
    var
        IsHandled: Boolean;
    begin
        OnBeforeImportFile(FileImport, IsHandled);
        DoImportFile(FileImport, IsHandled);
        OnAfterImportFile(FileImport);
    end;

    local procedure DoImportFile(var FileImport: Record "File Import PTE"; IsHandled: Boolean)
    var
        FileInStream: InStream;
        AllFilesTxt: Label 'All Files (*.*)|*.*';
        FileNameTooLongErr: Label 'The file name is too long. The maximum supported length is %1 characters.', Comment = '%1=No. of characters';
        NoFileSelectedErr: Label 'No file was selected.';
        SelectFileTxt: Label 'Select file...';
        FileOutStream: OutStream;
        FileName: Text;
    begin
        if IsHandled then
            exit;

        UploadIntoStream(SelectFileTxt, '', AllFilesTxt, FileName, FileInStream);

        if FileName = '' then
            Error(ErrorInfo.Create(NoFileSelectedErr));

        if StrLen(FileName) = MaxStrLen(FileImport."File Name") then
            Error(ErrorInfo.Create(FileNameTooLongErr));

        FileImport.Init();
        FileImport."Entry No." := 0; // Auto-increment
        FileImport."File Name" := CopyStr(FileName, 1, MaxStrLen(FileImport."File Name"));
        FileImport."File BLOB".CreateOutStream(FileOutStream);
        CopyStream(FileOutStream, FileInStream);
        FileImport.Insert(true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeImportFile(var FileImport: Record "File Import PTE"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterImportFile(var FileImport: Record "File Import PTE")
    begin
    end;
}