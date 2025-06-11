namespace PieterKok.ALCodeExperiments;

using System.Upgrade;

codeunit 50203 "Upgrade Data Transfer PTE"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        CopySourceToTarget();
    end;

    local procedure CopySourceToTarget()
    var
        TargetTable: Record "Target Table PTE";
        UpgradeTag: Codeunit "Upgrade Tag";
        TargetDataTransfer: DataTransfer;
    begin
        if UpgradeTag.HasUpgradeTag(CopySourceToTargetLbl) then
            exit;

        TargetDataTransfer.SetTables(Database::"Source Table PTE", Database::"Target Table PTE");
        TargetDataTransfer.AddFieldValue(2, TargetTable.FieldNo(Description));

        //SystemId cannot be transferred:
        //Systeem-id wordt niet ondersteund als doelveld voor gegevensoverdracht. Alleen 'normale' velden die zijn geactiveerd, en die geen systeemveld, geen controleveld en geen onderdeel van de primaire sleutel zijn, zijn geldige doelvelden.
        //TargetDataTransfer.AddFieldValue(2000000000, TargetTable.FieldNo(SystemId));

        TargetDataTransfer.CopyRows();

        UpgradeTag.SetUpgradeTag(CopySourceToTargetLbl);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]])
    begin
        PerCompanyUpgradeTags.Add(CopySourceToTargetLbl);
    end;


    var
        CopySourceToTargetLbl: Label 'PKO-CopySourceToTarget-20230206', Locked = true;
}