namespace PieterKok.ALCodeExperiments;

using System.Environment;
using System.Utilities;

report 50200 "Image Library PTE"
{
    Caption = 'Image Library';
    DefaultLayout = RDLC;
    RDLCLayout = './src/02-imagescaling/ImageLibrary.rdlc';
    UsageCategory = None;

    dataset
    {
        dataitem(ImageLibrary; "Image Library PTE")
        {
            column(EntryNo; "Entry No.") { }
            column(Description; Description) { }
            column(SourceHeight; "Source Height") { }
            column(SourceWidth; "Source Width") { }
            column(Image; TempTenantMedia.Content) { }
            column(HasImage; TempTenantMedia.Content.HasValue) { }

            trigger OnAfterGetRecord()
            begin
                Clear(TempTenantMedia);

                if TenantMedia.Get(ImageLibrary."Source Image".MediaId) then begin
                    TenantMedia.CalcFields(Content);
                    if TenantMedia.Content.HasValue then begin
                        TempTenantMedia := TenantMedia;
                        Resize(TempTenantMedia, 500, 500);
                    end;
                end;
            end;
        }
    }

    var
        TempTenantMedia: Record "Tenant Media" temporary;
        TenantMedia: Record "Tenant Media";

    local procedure Resize(var TempTenantMediaParameter: Record "Tenant Media" temporary; RequestedWidth: Integer; RequestedHeight: Integer)
    var
        Image: Codeunit Image;
        ImageInStream: InStream;
        CurrentHeight: Integer;
        CurrentWidth: Integer;
        NewHeight: Integer;
        NewWidth: Integer;
        ImageOutStream: OutStream;
    begin
        TempTenantMediaParameter.Content.CreateInStream(ImageInStream);
        Image.FromStream(ImageInStream);
        CurrentWidth := Image.GetWidth();
        CurrentHeight := Image.GetHeight();

        if CurrentWidth > RequestedWidth then begin
            NewHeight := Round(CurrentHeight * (RequestedWidth / CurrentWidth), 1, '>');
            Image.Resize(RequestedWidth, NewHeight);
        end;

        CurrentWidth := Image.GetWidth();
        CurrentHeight := Image.GetHeight();

        if CurrentHeight > RequestedHeight then begin
            NewWidth := Round(CurrentWidth * (RequestedHeight / CurrentHeight), 1, '>');
            Image.Resize(NewWidth, RequestedHeight);
        end;

        Image.Crop(1, 1, RequestedWidth, RequestedHeight);
        TempTenantMediaParameter.Content.CreateOutStream(ImageOutStream);
        Image.Save(ImageOutStream);
    end;
}
