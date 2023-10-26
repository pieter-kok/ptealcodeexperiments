table 50205 "Contract PTE"
{
    Caption = 'Contract';
    DataClassification = CustomerContent;
    LookupPageId = "Contract List PTE";
    DrillDownPageId = "Contract List PTE";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if not Customer.Get("Customer No.") then
                    Clear(Customer);

                Validate("Customer Name", Customer."Name");
            end;
        }
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}