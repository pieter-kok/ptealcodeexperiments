namespace PieterKok.ALCodeExperiments;

using System.Utilities;

page 50211 "Date With Day of Week"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = Date;
    SourceTableView = where("Period Type" = const(Date));
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Date; Rec."Period Start")
                {
                    ToolTip = 'Specifies a date';
                }
                field(DayOfWeekProcedure; Rec."Period Start".DayOfWeek)
                {
                    Caption = 'Day of Week (Procedure)';
                    ToolTip = 'Specifies the day of the week';
                }
                field(DWY; GetDayOfDayWeekYear())
                {
                    Caption = 'Day of Week (DWY)';
                    ToolTip = 'Specifies the day of the week';
                }

            }
        }
    }

    procedure GetDayOfDayWeekYear(): Integer
    begin
        exit(Date2DWY(Rec."Period Start", 1));
    end;
}