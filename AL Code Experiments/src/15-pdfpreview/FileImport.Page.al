namespace PieterKok.ALCodeExperiments;

page 50212 "File Import PTE"
{
    ApplicationArea = All;
    Caption = 'File Import';
    PageType = List;
    SourceTable = "File Import PTE";
    SourceTableView = sorting("Entry No.") order(descending);
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.") { }
                field("File Name"; Rec."File Name")
                {
                    trigger OnDrillDown()
                    begin
                        Rec.PreviewFile();
                    end;
                }
                field("Contains File"; Rec."File BLOB".HasValue())
                {
                    Caption = 'Contains File';
                    ToolTip = 'Specifies whether the file itself is linked to the file import record.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Import)
            {
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;
                ToolTip = 'Imports a selected file.';

                trigger OnAction()
                var
                    ImportFileMeth: Codeunit "Import File Meth PTE";
                begin
                    ImportFileMeth.ImportFile(Rec);
                    if Rec.FindFirst() then; //Select the first record based on the current filtering after importing
                end;
            }
            action(Preview)
            {
                Caption = 'Preview';
                Ellipsis = true;
                Image = PreviewChecks;
                ToolTip = 'Shows the preview of the current file.';

                trigger OnAction()
                begin
                    Rec.PreviewFile();
                end;
            }

            action(Download)
            {
                Caption = 'Download';
                Ellipsis = true;
                Image = Download;
                ToolTip = 'Downloads the current file.';

                trigger OnAction()
                begin
                    Rec.DownloadFile();
                end;
            }
        }

        area(Promoted)
        {
            actionref(Import_Promoted; Import) { }
            actionref(Preview_Promoted; Preview) { }
            actionref(Download_Promoted; Download) { }
        }
    }
}