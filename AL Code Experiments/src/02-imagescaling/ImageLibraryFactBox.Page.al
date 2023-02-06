page 50202 "Image Library FactBox PTE"
{
    Caption = 'Images';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Image Library PTE";

    layout
    {
        area(content)
        {
            group(Source)
            {
                Caption = 'Source';
                field("Source Image"; Rec."Source Image")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Specifies the source image.';
                }
            }
            group(Target)
            {
                Caption = 'Target';
                field("Target Image"; Rec."Target Image")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Specifies the target image.';
                }
            }
        }
    }
}