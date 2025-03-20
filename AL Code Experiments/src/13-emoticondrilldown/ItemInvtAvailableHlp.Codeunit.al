codeunit 50209 "Item Invt. Available Hlp. PTE"
{
    procedure GetInventoryIndicator(var Item: Record Item): Text;
    begin
        if Item.Inventory > 0 then
            exit('🟢')
        else
            exit('🔴');
    end;

    procedure ShowInventory(var Item: Record Item)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        PageManagement: Codeunit "Page Management";
    begin
        ItemLedgerEntry.SetRange("Item No.", Item."No.");
        if Item.GetFilter("Global Dimension 1 Filter") <> '' then
            ItemLedgerEntry.SetFilter("Global Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
        if Item.GetFilter("Global Dimension 2 Filter") <> '' then
            ItemLedgerEntry.SetFilter("Global Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
        if Item.GetFilter("Location Filter") <> '' then
            ItemLedgerEntry.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        if Item.GetFilter("Drop Shipment Filter") <> '' then
            ItemLedgerEntry.SetFilter("Drop Shipment", Item.GetFilter("Drop Shipment Filter"));
        if Item.GetFilter("Variant Filter") <> '' then
            ItemLedgerEntry.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        if Item.GetFilter("Lot No. Filter") <> '' then
            ItemLedgerEntry.SetFilter("Lot No.", Item.GetFilter("Lot No. Filter"));
        if Item.GetFilter("Serial No. Filter") <> '' then
            ItemLedgerEntry.SetFilter("Serial No.", Item.GetFilter("Serial No. Filter"));
        if Item.GetFilter("Unit of Measure Filter") <> '' then
            ItemLedgerEntry.SetFilter("Unit of Measure Code", Item.GetFilter("Unit of Measure Filter"));
        if Item.GetFilter("Package No. Filter") <> '' then
            ItemLedgerEntry.SetFilter("Package No.", Item.GetFilter("Package No. Filter"));
        PageManagement.PageRun(ItemLedgerEntry);
    end;
}