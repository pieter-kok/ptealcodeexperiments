namespace PieterKok.ALCodeExperiments;

codeunit 50213 "File Import Helper PTE"
{
    Access = Internal;
    procedure PreviewFile(FileImport: Record "File Import PTE")
    var
        FileInStream: InStream;
    begin
        GetBlob(FileImport, FileInStream);
        File.ViewFromStream(FileInStream, FileImport."File Name", true);
    end;

    procedure DownloadFile(var FileImport: Record "File Import PTE")
    var
        FileInStream: InStream;
        DownloadLbl: Label 'Download';
        FileName: Text;
    begin
        GetBlob(FileImport, FileInStream);
        FileName := FileImport."File Name";
        File.DownloadFromStream(FileInStream, DownloadLbl, '', '*.*', FileName);
    end;

    local procedure GetBlob(var FileImport: Record "File Import PTE"; var FileInStream: InStream)
    var
        NoFileErr: Label 'No file is linked to the %1 with %2 = ''%3''', Comment = '%1=Table Caption, %2=Field Caption, %3=Entry No.';
    begin
        if not FileImport."File BLOB".HasValue() then
            Error(NoFileErr, FileImport.TableCaption, FileImport.FieldCaption("Entry No."), FileImport."Entry No.");

        FileImport.CalcFields("File BLOB");
        FileImport."File BLOB".CreateInStream(FileInStream);
    end;
}