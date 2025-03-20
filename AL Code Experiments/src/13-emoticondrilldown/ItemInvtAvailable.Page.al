page 50212 "Item Invt. Available PTE"
{
    ApplicationArea = All;
    Caption = 'Item Invt. Available';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies the total quantity of the item that is currently in inventory at all locations.';
                }
                field(InventoryIndicator; ItemInvtAvailableHlpPTE.GetInventoryIndicator(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Indicator';
                    ToolTip = 'Specifies whether the item is in stock.';

                    trigger OnDrillDown()
                    begin
                        ItemInvtAvailableHlpPTE.ShowInventory(Rec);
                    end;
                }

            }
        }
    }

    var
        ItemInvtAvailableHlpPTE: Codeunit "Item Invt. Available Hlp. PTE";
}