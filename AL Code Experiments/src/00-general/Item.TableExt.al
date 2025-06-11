namespace PieterKok.ALCodeExperiments;

using Microsoft.Inventory.Item;

tableextension 50200 "Item PTE" extends Item
{
    fields
    {
        field(50200; "Extended Comment PTE"; Blob)
        {
            Caption = 'Extended Comment';
            DataClassification = CustomerContent;
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Item Category Code") { }
    }
}
