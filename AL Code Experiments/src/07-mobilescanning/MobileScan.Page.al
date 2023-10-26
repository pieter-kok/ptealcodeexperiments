page 50209 "Mobile Scan PTE"
{
    ApplicationArea = All;
    Caption = 'Mobile Scan';
    PageType = Card;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(BarCodeValueControl; BarCodeValue)
                {
                    ApplicationArea = All;
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
