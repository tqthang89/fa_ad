<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImagesAuditDetail.aspx.cs" Inherits="ECS_Web.Popups.ImagesAuditDetail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../slider/js/jquery-1.11.2.min.js"></script>
    <style type="text/css">
        .smooth_zoom_icons {
            background-image: url(../slider/images/icons.png);
        }
    </style>
    <script src="../Slider/js/jquery.smoothZoom.min.js" type="text/javascript"></script>

    <link href="../Choose/bootstrap.min.css" rel="stylesheet" />
    <link href="../Choose/bootstrap-chosen.css" rel="stylesheet" />
    <script src="../Choose/bootstrap.js"></script>
    <script src="../Choose/chosen.jquery.js"></script>
    <script type="text/javascript">
        function getQuerystring(key, default_) {
            if (default_ == null) default_ = "";
            key = key.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + key + "=([^&#]*)");
            var qs = regex.exec(window.location.href);
            if (qs == null)
                return default_;
            else
                return qs[1];
        }

        $(function () {
            $('#yourImageID1').attr('src', getQuerystring('src1'));
        });

        jQuery(function ($) {
            $('#yourImageID1').smoothZoom({
                width: 790,
                height: 591,
                responsive: false,
                responsive_maintain_ratio: true,
                max_WIDTH: '',
                max_HEIGHT: ''
            });
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Path="~/Choose/bootstrap.js" />
                <asp:ScriptReference Path="~/Choose/chosen.jquery.js" />
            </Scripts>
        </asp:ToolkitScriptManager>
        <script type="text/javascript" lang="javascript">
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                try {
                    if (endRequest != null && typeof (endRequest) == 'function') {
                        endRequest();
                        $('select').chosen();
                        $('select').chosen({ allow_single_deselect: true });
                    }
                }
                catch (ex) {
                }
            }
        </script>
        <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Conditional">
            <ContentTemplate>
                <div style="text-align: center;">
                    <img id="yourImageID1" width="743" />
                </div>
                <div class="clearfix" style="width: 100%; text-align: center; padding-top: 5px;"
                    runat="server" id="Div1">
                    <asp:ImageButton ID="ImageButton4" Width="24px" runat="server" align="absmiddle" ImageUrl="~/Images/Fast-backward-icon.png"
                        OnClick="ImageButton4_Click" />
                    <asp:DropDownList runat="server" CssClass="select2" ID="ddlPage" DataTextField="Desc" DataValueField="ImagePath" OnSelectedIndexChanged="ddlPage_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    <asp:Label ID="lbfrom1" runat="server" Style="font-size: 12px;"></asp:Label>/
                    <asp:Label ID="lbto1" runat="server" Style="font-size: 12px;"></asp:Label>
                    <asp:ImageButton ID="ImageButton5" Width="24px" runat="server" align="absmiddle" ImageUrl="~/Images/Fast-forward-icon.png"
                        OnClick="ImageButton5_Click" />

                     <asp:ImageButton ID="img_left" Width="19px" runat="server" align="absmiddle" ImageUrl="~/Images/rotate_left.png"
                        OnClick="img_left_Click" />
                    <asp:ImageButton ID="img_right" Width="24px" runat="server" align="absmiddle" ImageUrl="~/Images/rotate_right.png"
                        OnClick="img_right_Click" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <script>
            $(function () {
                init_ajax();
            });
            function init_ajax() {
                $('select').chosen();
                $('select').chosen({ allow_single_deselect: true });
            }
        </script>
    </form>
</body>
</html>
