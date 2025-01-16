<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportPhoto.aspx.cs" Inherits="ECS_Web.Report.ReportPhoto" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../slider/css/jquery.ad-gallery.css" />
    <script src="../slider/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var galleries = $('.ad-gallery').adGallery();
        });
        function openNewImage(file, WorkId, KPIId) {
            popWindow_ImageAudit("../Popups/ImagesAuditDetail.aspx?src1=" + file + "&WorkId=" + WorkId + "&KPIId=" + KPIId, 820, 635);
        }
        function popWindow_ImageAudit(link, width, height) {
            var w = width, h = height;
            var left = (screen.width / 2) - (w / 2);
            var top = 10;
            window.open(link, 'popup', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
            return false;
        }

    </script>
    <script src="../Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../slider/js/jquery.ad-gallery.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Literal runat="server" ID="ltrSlider"></asp:Literal>
        </div>
    </form>
</body>
</html>
