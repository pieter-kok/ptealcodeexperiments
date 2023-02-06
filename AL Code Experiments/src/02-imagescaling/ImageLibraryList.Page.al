page 50203 "Image Library List PTE"
{
    AdditionalSearchTerms = 'Image Library List';
    ApplicationArea = All;
    Caption = 'Image Library';
    CardPageId = "Image Library Card PTE";
    Editable = false;
    PageType = List;
    SourceTable = "Image Library PTE";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies an entry number.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description for the image.';
                }
                field("Source Base64"; Rec."Source Base64".HasValue)
                {
                    ApplicationArea = All;
                    Caption = 'Source Base64 Available';
                    ToolTip = 'Specifies whether the Base64 version of the source image is available.';
                    Editable = false;
                }
                field("Source Height"; Rec."Source Height")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the height of the source image.';
                }
                field("Source Width"; Rec."Source Width")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the width of the source image.';
                }
                field("Source Format"; Rec."Source Format")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the format of the source image.';
                }
                field("Source Format Text"; Rec."Source Format Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the text representation of the format of the source image.';
                }
                field("Target Base64"; Rec."Target Base64".HasValue)
                {
                    ApplicationArea = All;
                    Caption = 'Target Base64 Available';
                    ToolTip = 'Specifies whether the Base64 version of the target image is available.';
                    Editable = false;
                }
                field("Target Height"; Rec."Target Height")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the height of the target image.';
                }
                field("Target Width"; Rec."Target Width")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the width of the target image.';
                }
                field("Target Format"; Rec."Target Format")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the format of the target image.';
                }
                field("Target Format Text"; Rec."Target Format Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the text representation of the format of the target image.';
                }
            }
        }
        area(FactBoxes)
        {
            part("Image Library FactBox PTE"; "Image Library FactBox PTE")
            {
                ApplicationArea = All;
                SubPageLink = "Entry No." = field("Entry No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(ReportActions)
            {
                action(Print)
                {
                    ApplicationArea = All;
                    Caption = 'Print';
                    Image = Print;
                    ToolTip = 'Print the image library.';

                    trigger OnAction()
                    begin
                        Rec.PrintImageLibrary();
                    end;
                }
            }
            group(SourceActions)
            {
                Caption = 'Source';

                action(ImportSourceImage)
                {
                    ApplicationArea = All;
                    Caption = 'Import Source Image';
                    Image = Import;
                    ToolTip = 'Uploads an image as source image.';

                    trigger OnAction()
                    begin
                        Rec.ImportImage(Rec.FieldNo("Source Image"));
                    end;
                }
                action(DeleteSourceImage)
                {
                    ApplicationArea = All;
                    Caption = 'Delete Source Image';
                    Image = Delete;
                    ToolTip = 'Deletes the current source image.';

                    trigger OnAction()
                    begin
                        Rec.DeleteImage(Rec.FieldNo("Source Image"));
                    end;
                }
                action(ExportSourceImageMedia)
                {
                    ApplicationArea = All;
                    Caption = 'Export Source Image';
                    Image = Export;
                    ToolTip = 'Exports the current source image.';

                    trigger OnAction()
                    begin
                        Rec.ExportImageFromMedia(Rec.FieldNo("Source Image"));
                    end;
                }
                action(ExportSourceImageBase64)
                {
                    ApplicationArea = All;
                    Caption = 'Export Source Base64';
                    Image = Export;
                    ToolTip = 'Exports the base64 version of the source image .';

                    trigger OnAction()
                    begin
                        Rec.ExportBase64(Rec.FieldNo("Source Base64"));
                    end;
                }
            }
            group(TargetActions)
            {
                Caption = 'Target';

                action(DeleteTargetImage)
                {
                    ApplicationArea = All;
                    Caption = 'Delete Target Image';
                    Image = Delete;
                    ToolTip = 'Deletes the current target image.';

                    trigger OnAction()
                    begin
                        Rec.DeleteImage(Rec.FieldNo("Target Image"));
                    end;
                }
                action(ExportTargetImage)
                {
                    ApplicationArea = All;
                    Caption = 'Export Target Image';
                    Image = Export;
                    ToolTip = 'Exports the current target image.';

                    trigger OnAction()
                    begin
                        Rec.ExportImageFromMedia(Rec.FieldNo("Target Image"));
                    end;
                }
                action(ExportTargetBase64)
                {
                    ApplicationArea = All;
                    Caption = 'Export Target Base64';
                    Image = Export;
                    ToolTip = 'Exports the base64 version of the current target image .';

                    trigger OnAction()
                    begin
                        Rec.ExportBase64(Rec.FieldNo("Target Base64"));
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';

                actionref(Print_Promoted; Print)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Source', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(ImportSourceImage_Promoted; ImportSourceImage)
                {
                }
                actionref(DeleteSourceImage_Promoted; DeleteSourceImage)
                {
                }
                actionref(ExportSourceImageMedia_Promoted; ExportSourceImageMedia)
                {
                }
                actionref(ExportSourceImageBase64_Promoted; ExportSourceImageBase64)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Functions', Comment = 'Generated from the PromotedActionCategories property index 4.';
            }
            group(Category_Category6)
            {
                Caption = 'Target', Comment = 'Generated from the PromotedActionCategories property index 5.';

                actionref(DeleteTargetImage_Promoted; DeleteTargetImage)
                {
                }
                actionref(ExportTargetImage_Promoted; ExportTargetImage)
                {
                }
                actionref(ExportTargetBase64_Promoted; ExportTargetBase64)
                {
                }
            }
        }
    }


}