namespace PieterKok.ALCodeExperiments;

using System.Text;

page 50205 "Hierarchy Descr. Tree PTE"
{
    ApplicationArea = All;
    Caption = 'Hierarchy Description Tree';
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Hierarchy Descr. PTE";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                Caption = 'Filters';

                field(DescriptionFilterControl; DescriptionFilter)
                {
                    Caption = 'Description Filter';
                    ToolTip = 'Specifies a filter on description.';

                    trigger OnValidate()
                    var
                        FilterHelperTriggers: Codeunit "Filter Helper Triggers";
                    begin
                        FilterHelperTriggers.MakeTextFilter(DescriptionFilter);
                        UpdateFilters();
                    end;
                }

            }
            repeater(General)
            {
                IndentationColumn = Rec.Level;
                ShowAsTree = true;
                TreeInitialState = ExpandAll;

                field("Code"; Rec."Code")
                {
                    Editable = false;
                    StyleExpr = CurrStyleExpr;
                    ToolTip = 'Specifies a code.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    StyleExpr = CurrStyleExpr;
                    ToolTip = 'Specifies a description.';
                }
                field(Level; Rec.Level)
                {
                    StyleExpr = CurrStyleExpr;
                    ToolTip = 'Specifies the level for the hierarchy.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(Style; Rec.Style)
                {
                    StyleExpr = CurrStyleExpr;
                    ToolTip = 'Specifies the style.';

                    trigger OnValidate()
                    begin
                        SetStyleExpr()
                    end;
                }

            }
        }
    }

    var
        CurrStyleExpr: Text;
        DescriptionFilter: Text;

    trigger OnAfterGetCurrRecord()
    begin
        SetStyleExpr();
    end;

    trigger OnAfterGetRecord()
    begin
        SetStyleExpr();
    end;

    local procedure SetStyleExpr()
    begin
        CurrStyleExpr := Rec.GetStyleExpr();
    end;

    local procedure UpdateFilters()
    begin
        if DescriptionFilter = '' then
            Rec.SetRange(Description)
        else
            Rec.SetFilter(Description, DescriptionFilter);

        CurrPage.Update();
    end;


}
