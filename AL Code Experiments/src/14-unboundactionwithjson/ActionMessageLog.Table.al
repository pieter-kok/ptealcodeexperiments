namespace PieterKok.ALCodeExperiments;

table 50206 "Action Message Log PTE"
{
    Caption = 'Action Message Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies a unique entry number for the action message log.';
        }
        field(10; Request; Blob)
        {
            Caption = 'Request';
            ToolTip = 'Specifies the received request json.';
        }
        field(20; "Created On"; Date)
        {
            Caption = 'Created On';
            ToolTip = 'Specifies the date on which the action message is created.';
        }
        field(30; "Created At"; Time)
        {
            Caption = 'Created At';
            ToolTip = 'Specifies the time on which the action message is created.';
        }
        field(40; "Created By"; Code[50])
        {
            Caption = 'Created By';
            ToolTip = 'Specifies the user on which the action message is created.';
        }
        field(50; "Error Text"; Text[1024])
        {
            Caption = 'Error Text';
            ToolTip = 'Specifies the error text that occurred during processing the action message.';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        ActionMessageLogHelper: Codeunit "Action Message Log Helper PTE";

    internal procedure Create()
    begin
        ActionMessageLogHelper.Create(Rec);
    end;

    internal procedure AddRequest(RequestJson: JsonToken)
    begin
        ActionMessageLogHelper.AddRequest(Rec, RequestJson);
    end;
}