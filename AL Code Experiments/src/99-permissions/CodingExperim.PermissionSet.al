permissionset 50200 "Coding Experim. PTE"
{
    Assignable = true;
    Caption = 'Coding Experiments';
    Permissions =
        table "Report Substitution PTE" = X,
        tabledata "Report Substitution PTE" = RMID,
        table "Image Library PTE" = X,
        tabledata "Image Library PTE" = RMID,
        table "Hierarchy Descr. PTE" = X,
        tabledata "Hierarchy Descr. PTE" = RMID,
        codeunit "ReportManagement Subscr. PTE" = X,
        codeunit "Image Library Helper PTE" = X,
        codeunit "Hierarchy Descr. Helper PTE" = X,
        page "Report Substitutions PTE" = X,
        page "Image Library FactBox PTE" = X,
        page "Hierarchy Descr. PTE" = X,
        page "Image Library Card PTE" = X,
        page "Image Library List PTE" = X,
        page "Hierarchy Descr. Tree PTE" = X,
        report "Image Library PTE" = X;
}