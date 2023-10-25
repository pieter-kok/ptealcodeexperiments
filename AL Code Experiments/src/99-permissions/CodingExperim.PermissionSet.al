permissionset 50200 "Coding Experim. PTE"
{
    Assignable = true;
    Caption = 'Coding Experiments';
    Permissions = table "Report Substitution PTE" = X,
        tabledata "Report Substitution PTE" = RMID,
        table "Image Library PTE" = X,
        tabledata "Image Library PTE" = RMID,
        table "Hierarchy Descr. PTE" = X,
        tabledata "Contract PTE" = RMID,
        table "Contract PTE" = X,
        tabledata "Hierarchy Descr. PTE" = RMID,
        codeunit "ReportManagement Subscr. PTE" = X,
        codeunit "Image Library Helper PTE" = X,
        codeunit "Hierarchy Descr. Helper PTE" = X,
        codeunit "Data Search Events Subscr. PTE" = X,
        codeunit "Upgrade Data Transfer PTE" = X,
        page "Report Substitutions PTE" = X,
        page "Image Library FactBox PTE" = X,
        page "Hierarchy Descr. PTE" = X,
        page "Image Library Card PTE" = X,
        page "Image Library List PTE" = X,
        page "Hierarchy Descr. Tree PTE" = X,
        report "Image Library PTE" = X,
        tabledata "Source Table PTE" = RIMD,
        tabledata "Target Table PTE" = RIMD,
        table "Source Table PTE" = X,
        table "Target Table PTE" = X,
        page "Source Table List PTE" = X,
        page "Target Table List PTE" = X,
        page "Contract Card PTE" = X,
        page "Contract List PTE" = X,
        page "Mobile Scan PTE" = X;
}