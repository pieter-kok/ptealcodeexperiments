pageextension 50204 "Purchase Order List PTE" extends "Purchase Order List"
{
    actions
    {
        addafter(Print)
        {
            action(DownloadPTE)
            {
                ApplicationArea = All;
                Caption = 'Download';
                Image = Download;
                ToolTip = 'Download the document in the report selected layout.';

                trigger OnAction()
                var
                    GeneratePurchOrderDoc: Codeunit "Generate Purch. Order Doc. PTE";
                begin
                    Rec.TestField("No.");
                    GeneratePurchOrderDoc.SaveDocument(Rec."Document Type", Rec."No.");
                end;
            }
        }
        addafter(Print_Promoted)
        {
            actionref(DownloadPTE_Promoted; DownloadPTE) { }
        }
    }
}