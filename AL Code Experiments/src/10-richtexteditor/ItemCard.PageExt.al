namespace PieterKok.ALCodeExperiments;

using Microsoft.Inventory.Item;

pageextension 50203 "Item Card PTE" extends "Item Card"
{
    layout
    {
        addlast(content)
        {
            group("RichTextDemoPTE PTE")
            {
                Caption = 'Extended Comment';

                field(ExtendedCommentControlPTE; RichTextPTE)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = RichContent;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the multiline comment in a rich text editor.';

                    trigger OnValidate()
                    var
                        CommentOutStream: OutStream;
                    begin
                        Clear(Rec."Extended Comment PTE");
                        Rec."Extended Comment PTE".CreateOutStream(CommentOutStream, TextEncoding::UTF8);
                        CommentOutStream.WriteText(RichTextPTE);
                        SaveRecord();
                    end;
                }

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CommentInStream: InStream;
    begin
        Rec.CalcFields("Extended Comment PTE");
        Rec."Extended Comment PTE".CreateInStream(CommentInStream, TextEncoding::UTF8);
        CommentInStream.ReadText(RichTextPTE);
    end;

    var
        RichTextPTE: Text;
}
