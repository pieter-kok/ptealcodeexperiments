codeunit 50204 "Data Search Events Subscr. PTE"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Data Search Events", 'OnAfterGetFieldListForTable', '', false, false)]
    local procedure OnAfterGetFieldListForTable(TableNo: Integer; var ListOfFieldNumbers: List of [Integer])
    var
        Contract: Record "Contract PTE";
    begin
        TableNo := Database::"Contract PTE";
        ListOfFieldNumbers.Remove(Contract.FieldNo("Customer No."));
        //ListOfFieldNumbers.Add(Contract.FieldNo("Customer Name"));
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Data Search Events", 'OnAfterGetRolecCenterTableList', '', false, false)]
    local procedure OnAfterGetRolecCenterTableList(RoleCenterID: Integer; var ListOfTableNumbers: List of [Integer])
    begin
        RoleCenterID := Page::"Business Manager Role Center";
        ListOfTableNumbers.Add(Database::"Contract PTE");
    end;
}