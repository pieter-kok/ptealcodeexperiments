namespace PieterKok.ALCodeExperiments;

page 50209 "Mobile Scan PTE"
{
    ApplicationArea = All;
    Caption = 'Mobile Scan';
    PageType = Card;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(BarCodeValueControl; BarCodeValue)
                {
                    Caption = 'Bar Code';
                    ExtendedDatatype = Barcode;
                    ToolTip = 'Scan or enter a bar code.';
                }
            }
        }
    }

    var
        BarCodeValue: Text;
}
