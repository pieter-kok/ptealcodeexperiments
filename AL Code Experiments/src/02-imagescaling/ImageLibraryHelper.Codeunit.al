namespace PieterKok.ALCodeExperiments;

using System.Environment;
using System.Utilities;

codeunit 50201 "Image Library Helper PTE"
{
    var
        AllFilesLbl: Label 'All Files (*.*)|*.*';
        DeleteImageQst: Label 'Are you sure you want to delete the image?';
        ImportLbl: Label 'Import';
        NoImageFoundErr: Label 'No image found.';
        OverrideImageQst: Label 'The existing image will be replaced. Do you want to continue?';
        TargetLbl: Label 'Target';

    internal procedure ImportImage(var ImageLibrary: Record "Image Library PTE"; CalledFromFieldNo: Integer)
    var
        Image: Codeunit Image;
        TempBlob: Codeunit "Temp Blob";
        ImageInStream: InStream;
        ImageOutStream: OutStream;
        ImageFileName: Text;
    begin
        InitializeImageLibrary(ImageLibrary);
        if not ConfirmOverrideImage(ImageLibrary, CalledFromFieldNo) then
            exit;


        if UploadIntoStream(ImportLbl, '', AllFilesLbl, ImageFileName, ImageInStream) then begin
            case CalledFromFieldNo of
                ImageLibrary.FieldNo("Source Image"):
                    begin
                        Clear(ImageLibrary."Source Image");
                        ImageLibrary.Description := CopyStr(ImageFileName, 1, MaxStrLen(ImageLibrary.Description));
                        ImageLibrary."Source Image".ImportStream(ImageInStream, ImageFileName);

                        TempBlob.CreateOutStream(ImageOutStream);
                        ImageLibrary."Source Image".ExportStream(ImageOutStream);
                        if TempBlob.HasValue() then begin
                            TempBlob.CreateInStream(ImageInStream);
                            Image.FromStream(ImageInStream);
                            ImageLibrary."Source Height" := Image.GetHeight();
                            ImageLibrary."Source Width" := Image.GetWidth();
                            ImageLibrary."Source Format" := Image.GetFormat();
                            ImageLibrary."Source Format Text" := CopyStr(Image.GetFormatAsText(), 1, MaxStrLen(ImageLibrary."Source Format Text"));
                            ImageLibrary."Source Base64".CreateOutStream(ImageOutStream);
                            ImageOutStream.WriteText(Image.ToBase64());

                            ImageLibrary.Height := Image.GetHeight();
                            ImageLibrary.Width := Image.GetWidth();
                        end
                    end;
                ImageLibrary.FieldNo("Target Image"):
                    begin
                        Clear(ImageLibrary."Target Image");
                        ImageLibrary."Target Image".ImportStream(ImageInStream, ImageFileName);

                        TempBlob.CreateOutStream(ImageOutStream);
                        ImageLibrary."Target Image".ExportStream(ImageOutStream);
                        if TempBlob.HasValue() then begin
                            TempBlob.CreateInStream(ImageInStream);
                            Image.FromStream(ImageInStream);
                            ImageLibrary."Target Height" := Image.GetHeight();
                            ImageLibrary."Target Width" := Image.GetWidth();
                            ImageLibrary."Target Format" := Image.GetFormat();
                            ImageLibrary."Target Format Text" := CopyStr(Image.GetFormatAsText(), 1, MaxStrLen(ImageLibrary."Target Format Text"));
                            ImageLibrary."Target Base64".CreateOutStream(ImageOutStream);
                            ImageOutStream.WriteText(Image.ToBase64());

                            ImageLibrary.Height := Image.GetHeight();
                            ImageLibrary.Width := Image.GetWidth();
                        end
                    end;
            end;
            ImageLibrary.Modify(true);
        end;
    end;

    internal procedure DeleteImage(var ImageLibrary: Record "Image Library PTE"; CalledFromFieldNo: Integer)
    begin
        ImageLibrary.TestField("Entry No.");

        if not Confirm(DeleteImageQst) then
            exit;

        case CalledFromFieldNo of
            ImageLibrary.FieldNo("Source Image"):
                begin
                    Clear(ImageLibrary."Source Image");
                    Clear(ImageLibrary."Source Base64");
                    Clear(ImageLibrary."Source Height");
                    Clear(ImageLibrary."Source Width");
                    Clear(ImageLibrary."Source Format");
                    Clear(ImageLibrary."Source Format Text");
                end;
            ImageLibrary.FieldNo("Target Image"):
                begin
                    Clear(ImageLibrary."Target Image");
                    Clear(ImageLibrary."Target Base64");
                    Clear(ImageLibrary."Target Height");
                    Clear(ImageLibrary."Target Width");
                    Clear(ImageLibrary."Target Format");
                    Clear(ImageLibrary."Target Format Text");

                    ImageLibrary.Height := ImageLibrary."Source Height";
                    ImageLibrary.Width := ImageLibrary."Source Width";
                end
        end;

        ImageLibrary.Modify(true);
    end;

    internal procedure ExportImageFromMedia(var ImageLibrary: Record "Image Library PTE"; CalledFromFieldNo: Integer)
    var
        TenantMedia: Record "Tenant Media";
        ImageInStream: InStream;
        ImageFileName: Text;
    begin
        ImageLibrary.TestField("Entry No.");
        ImageLibrary.TestField(Description);

        case CalledFromFieldNo of
            ImageLibrary.FieldNo("Source Image"):
                if TenantMedia.Get(ImageLibrary."Source Image".MediaId) then
                    ImageFileName := ImageLibrary.Description;

            ImageLibrary.FieldNo("Target Image"):
                if TenantMedia.Get(ImageLibrary."Target Image".MediaId) then
                    ImageFileName := TargetLbl + ImageLibrary.Description;
        end;

        TenantMedia.CalcFields(Content);
        if TenantMedia.Content.HasValue then begin
            TenantMedia.Content.CreateInStream(ImageInStream);
            DownloadFromStream(ImageInStream, '', '', '', ImageFileName);
        end;
    end;

    internal procedure ExportBase64(var ImageLibrary: Record "Image Library PTE"; CalledFromFieldNo: Integer)
    var
        Base64InStream: InStream;
        TxtLbl: Label '.txt', Locked = true;
        Base64FileName: Text;
    begin
        ImageLibrary.TestField("Entry No.");
        ImageLibrary.TestField(Description);

        case CalledFromFieldNo of
            ImageLibrary.FieldNo("Source Base64"):
                if ImageLibrary."Source Base64".HasValue then begin
                    ImageLibrary.CalcFields("Source Base64");
                    ImageLibrary."Source Base64".CreateInStream(Base64InStream);
                    Base64FileName := ImageLibrary.Description + TxtLbl;
                end else
                    exit;
            ImageLibrary.FieldNo("Target Base64"):
                if ImageLibrary."Target Base64".HasValue then begin
                    ImageLibrary.CalcFields("Target Base64");
                    ImageLibrary."Target Base64".CreateInStream(Base64InStream);
                    Base64FileName := TargetLbl + ImageLibrary.Description + TxtLbl;
                end else
                    exit;
        end;

        DownloadFromStream(Base64InStream, '', '', '', Base64FileName);
    end;

    internal procedure SaveTargetImage(var ImageLibrary: Record "Image Library PTE"; var Image: Codeunit Image)
    var
        TempBlob: Codeunit "Temp Blob";
        ImageInStream: InStream;
        ImageOutStream: OutStream;

    begin
        TempBlob.CreateOutStream(ImageOutStream);
        Image.Save(ImageOutStream);

        TempBlob.CreateInStream(ImageInStream);
        ImageLibrary."Target Image".ImportStream(ImageInStream, ImageLibrary.Description);

        ImageLibrary."Target Height" := Image.GetHeight();
        ImageLibrary."Target Width" := Image.GetWidth();
        ImageLibrary."Target Format" := Image.GetFormat();
        ImageLibrary."Target Format Text" := CopyStr(Image.GetFormatAsText(), 1, MaxStrLen(ImageLibrary."Target Format Text"));
        ImageLibrary."Target Base64".CreateOutStream(ImageOutStream);
        ImageOutStream.WriteText(Image.ToBase64());

        ImageLibrary.Height := Image.GetHeight();
        ImageLibrary.Width := Image.GetWidth();

        ImageLibrary.Modify(true);
    end;

    internal procedure CropImage(var ImageLibrary: Record "Image Library PTE")
    var
        Image: Codeunit Image;
    begin
        if ImageLibrary."Target Base64".HasValue then
            Image.FromBase64(GetBase64Text(ImageLibrary, ImageLibrary.FieldNo("Target Image")))
        else begin
            if not ImageLibrary."Source Base64".HasValue then
                Error(NoImageFoundErr);

            Image.FromBase64(GetBase64Text(ImageLibrary, ImageLibrary.FieldNo("Source Image")));
        end;

        Image.Crop(ImageLibrary."Crop X", ImageLibrary."Crop Y", ImageLibrary.Width, ImageLibrary.Height);
        ImageLibrary.SaveTargetImage(Image);
    end;

    internal procedure ResizeImage(var ImageLibrary: Record "Image Library PTE")
    var
        Image: Codeunit Image;
    begin
        if ImageLibrary."Target Base64".HasValue then
            Image.FromBase64(GetBase64Text(ImageLibrary, ImageLibrary.FieldNo("Target Image")))
        else begin
            if not ImageLibrary."Source Base64".HasValue then
                Error(NoImageFoundErr);

            Image.FromBase64(GetBase64Text(ImageLibrary, ImageLibrary.FieldNo("Source Image")));
        end;

        Image.Resize(ImageLibrary.Width, ImageLibrary.Height);
        ImageLibrary.SaveTargetImage(Image);
    end;

    internal procedure PrintImageLibrary(var ImageLibrary: Record "Image Library PTE")
    begin
        Report.RunModal(Report::"Image Library PTE", true, false, ImageLibrary);
    end;

    local procedure GetBase64Text(var ImageLibrary: Record "Image Library PTE"; CalledFromFieldNo: Integer) Base64Text: Text
    var
        Base64InStream: InStream;
    begin
        case CalledFromFieldNo of
            ImageLibrary.FieldNo("Source Image"):
                if ImageLibrary."Source Base64".HasValue then begin
                    ImageLibrary.CalcFields("Source Base64");
                    ImageLibrary."Source Base64".CreateInStream(Base64InStream);
                end else
                    exit;
            ImageLibrary.FieldNo("Target Image"):
                if ImageLibrary."Target Base64".HasValue then begin
                    ImageLibrary.CalcFields("Target Base64");
                    ImageLibrary."Target Base64".CreateInStream(Base64InStream);
                end else
                    exit;
        end;

        Base64InStream.ReadText(Base64Text);
    end;

    local procedure ConfirmOverrideImage(var ImageLibrary: Record "Image Library PTE"; CalledFromFieldNo: Integer): Boolean
    var
        TenantMedia: Record "Tenant Media";
    begin
        case CalledFromFieldNo of
            ImageLibrary.FieldNo("Source Image"):
                if TenantMedia.Get(ImageLibrary."Source Image".MediaId) then
                    exit(Confirm(OverrideImageQst));
            ImageLibrary.FieldNo("Target Image"):
                if TenantMedia.Get(ImageLibrary."Target Image".MediaId) then
                    exit(Confirm(OverrideImageQst));
        end;

        exit(true);
    end;

    local procedure InitializeImageLibrary(var ImageLibrary: Record "Image Library PTE")
    begin
        if ImageLibrary."Entry No." = 0 then begin
            ImageLibrary.Init();
            ImageLibrary."Entry No." := 0;
            ImageLibrary.Insert(true);
        end;
    end;
}