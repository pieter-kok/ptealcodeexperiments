namespace PieterKok.ALCodeExperiments;

page 50213 "Action Message Logs PTE"
{
    ApplicationArea = All;
    Caption = 'Action Message Logs';
    PageType = List;
    SourceTable = "Action Message Log PTE";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Created On"; Rec."Created On") { }
                field("Created At"; Rec."Created At") { }
                field("Created By"; Rec."Created By") { }
                field("Contains Request"; Rec.Request.HasValue)
                {
                    Caption = 'Contains Request';
                    Editable = false;
                    ToolTip = 'Specifies whether there is request message stored in the message log.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DownloadRequest)
            {
                Image = Download;
                ToolTip = 'Downloads the json request that is stored in the action message log.';

                trigger OnAction()
                var
                    JsonInstream: InStream;
                    AllFilesLbl: Label 'All files (*.*)|*.*';
                    DownloadLbl: Label 'Download';
                    FileNameLbl: Label '%1 %2.json', Locked = true;
                    NotFoundErr: Label '%1 not found in %2 with %3=''%4''.', Comment = '%1=Request FieldCaption, %2=Action Message Log TableCaption, %3=Entry No. FieldCaption, %4=Entry No.';
                    UnexpectedDownloadErr: Label 'An unexpected error occurred during downloading the %1 of %2 with %3=''%4''.', Comment = '%1=Request FieldCaption, %2=Action Message Log TableCaption, %3=Entry No. FieldCaption, %4=Entry No.';
                    TempFileName: Text;
                begin
                    if not Rec.Request.HasValue() then
                        Error(ErrorInfo.Create(StrSubstNo(NotFoundErr, Rec.FieldCaption(Request), Rec.TableCaption(), Rec.FieldCaption("Entry No."), Rec."Entry No.")));

                    Rec.Request.CreateInStream(JsonInstream);
                    TempFileName := StrSubstNo(FileNameLbl, Rec.TableCaption(), Rec."Entry No.");
                    if not DownloadFromStream(JsonInstream, DownloadLbl, '', AllFilesLbl, TempFileName) then
                        Error(ErrorInfo.Create(StrSubstNo(UnexpectedDownloadErr, Rec.FieldCaption(Request), Rec.TableCaption(), Rec.FieldCaption("Entry No."), Rec."Entry No.")))
                end;
            }
        }
    }
}