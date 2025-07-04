namespace PieterKok.ALCodeExperiments;

codeunit 50202 "Hierarchy Descr. Helper PTE"
{
    internal procedure GetStyleExpr(var HierarchyDescr: Record "Hierarchy Descr. PTE") StyleExpr: Text
    var
        AmbiguousTxt: Label 'Ambiguous', Locked = true;
        AttentionAccentTxt: Label 'AttentionAccent', Locked = true;
        AttentionTxt: Label 'Attention', Locked = true;
        FavorableTxt: Label 'Favorable', Locked = true;
        NoneTxt: Label 'None', Locked = true;
        StandardAccentTxt: Label 'StandardAccent', Locked = true;
        StandardTxt: Label 'Standard', Locked = true;
        StrongAccentTxt: Label 'StrongAccent', Locked = true;
        StrongTxt: Label 'Strong', Locked = true;
        SubordinateTxt: Label 'Subordinate', Locked = true;
        UnfavorableTxt: Label 'Unfavorable', Locked = true;
    begin
        case HierarchyDescr.Style of
            HierarchyDescr.Style::None:
                exit(NoneTxt);
            HierarchyDescr.Style::Standard:
                exit(StandardTxt);
            HierarchyDescr.Style::StandardAccent:
                exit(StandardAccentTxt);
            HierarchyDescr.Style::Strong:
                exit(StrongTxt);
            HierarchyDescr.Style::StrongAccent:
                exit(StrongAccentTxt);
            HierarchyDescr.Style::Attention:
                exit(AttentionTxt);
            HierarchyDescr.Style::AttentionAccent:
                exit(AttentionAccentTxt);
            HierarchyDescr.Style::Favorable:
                exit(FavorableTxt);
            HierarchyDescr.Style::Unfavorable:
                exit(UnfavorableTxt);
            HierarchyDescr.Style::Ambiguous:
                exit(AmbiguousTxt);
            HierarchyDescr.Style::Subordinate:
                exit(SubordinateTxt);
            else
                OnCustomGetStyleExpr(HierarchyDescr.Style, StyleExpr);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCustomGetStyleExpr(Style: Enum "Hierarchy Style PTE"; var StyleExpr: Text)
    begin
    end;
}
