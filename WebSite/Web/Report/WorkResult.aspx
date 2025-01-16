<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="WorkResult.aspx.cs" Inherits="ECS_Web.Report.WorkResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* .nav-link.active {
            background-color: goldenrod !important;
        }
*/
        .img-fluid {
            width: 100%;
            height: auto;
        }
    </style>
    <script type="text/javascript">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <%--<div class="card-header">
                    <h3 class="card-title">Báo cáo viếng thăm cửa hàng (Audit - Mer)</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>--%>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Chu kỳ:</label>
                                <asp:DropDownList runat="server" ID="ddlCycle" OnSelectedIndexChanged="ddlCycle_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Từ ngày :</label>
                                <div class="input-group date" id="reservationdate" data-target-input="nearest">
                                    <%--<input type="text" class="form-control datetimepicker-input" data-target="#reservationdate" />--%>
                                    <asp:TextBox runat="server" ID="txtFromDate" CssClass="form-control datetimepicker-input" data-target="#reservationdate"></asp:TextBox>
                                    <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Đến ngày :</label>
                                <div class="input-group date" id="reservationdate1" data-target-input="nearest">
                                    <%--<input type="text" class="form-control datetimepicker-input" data-target="#reservationdate" />--%>
                                    <asp:TextBox runat="server" ID="txtToDate" CssClass="form-control datetimepicker-input" data-target="#reservationdate1"></asp:TextBox>
                                    <div class="input-group-append" data-target="#reservationdate1" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Khu vực:</label>
                                <asp:DropDownList runat="server" ID="ddlArea" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlArea_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Tỉnh/Thành phố:</label>
                                <asp:DropDownList runat="server" ID="ddlProvince" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true" OnSelectedIndexChanged="ddlProvince_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Quận/Huyện:</label>
                                <asp:DropDownList runat="server" ID="ddlDistrict" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Phường/Xã:</label>
                                <asp:DropDownList runat="server" ID="ddlTown" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Kênh:</label>
                                <asp:DropDownList runat="server" ID="ddlShopType" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Text="-Tất cả-" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="MT" Value="MT"></asp:ListItem>
                                    <asp:ListItem Text="GT" Value="GT"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Chuỗi siêu thị:</label>
                                <asp:DropDownList runat="server" ID="ddlSite" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Text="-Tất cả-" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="AB BEAUTYWORD" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="AEON" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="BEAUTY BOX" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="BHX" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="BIG C" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="COOP MART" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="EMART" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="FUJIMART" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="GROVE" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="GUARDIAN" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="HASAKI" Value="11"></asp:ListItem>
                                    <asp:ListItem Text="KOHNAN" Value="12"></asp:ListItem>
                                    <asp:ListItem Text="LOTTE" Value="13"></asp:ListItem>
                                    <asp:ListItem Text="MATSUMOTO" Value="14"></asp:ListItem>
                                    <asp:ListItem Text="MEDICARE" Value="15"></asp:ListItem>
                                    <asp:ListItem Text="MEGA" Value="16"></asp:ListItem>
                                    <asp:ListItem Text="MINISTOP" Value="17"></asp:ListItem>
                                    <asp:ListItem Text="NOVA MARKET" Value="18"></asp:ListItem>
                                    <asp:ListItem Text="PHARMACITY" Value="19"></asp:ListItem>
                                    <asp:ListItem Text="ROMEA" Value="20"></asp:ListItem>
                                    <asp:ListItem Text="SAKUKO" Value="21"></asp:ListItem>
                                    <asp:ListItem Text="SAMI" Value="22"></asp:ListItem>
                                    <asp:ListItem Text="SATRA" Value="23"></asp:ListItem>
                                    <asp:ListItem Text="SOCIOLLA" Value="24"></asp:ListItem>
                                    <asp:ListItem Text="VINMART" Value="25"></asp:ListItem>
                                    <asp:ListItem Text="MAXI" Value="26"></asp:ListItem>
                                    <asp:ListItem Text="WATSONS" Value="27"></asp:ListItem>
                                    <asp:ListItem Text="WELLNESS" Value="28"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" style="display: none;">
                            <div class="form-group">
                                <label>MDO:</label>
                                <asp:DropDownList runat="server" ID="ddlMDO" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" style="display: none;">
                            <div class="form-group">
                                <label>Gói TB:</label>
                                <asp:DropDownList runat="server" ID="ddlPNG" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="-1">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">DIAMOND</asp:ListItem>
                                    <asp:ListItem Value="2">GOLD</asp:ListItem>
                                    <asp:ListItem Value="3">TITAN</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Supervisor:</label>
                                <asp:DropDownList runat="server" ID="ddlSup" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true" OnSelectedIndexChanged="ddlSup_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Auditor:</label>
                                <asp:DropDownList runat="server" ID="ddlAuditor" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Kết quả CH:</label>
                                <asp:DropDownList runat="server" ID="ddlAuditResults" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Kết quả QC Cửa hàng:</label>
                                <asp:DropDownList runat="server" ID="ddlQC" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="-1">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="0">Chưa QC</asp:ListItem>
                                    <asp:ListItem Value="4">Đang QC</asp:ListItem>
                                    <asp:ListItem Value="5">Done QC</asp:ListItem>
                                    <asp:ListItem Value="1">Pass</asp:ListItem>
                                    <asp:ListItem Value="2">Reject</asp:ListItem>
                                    <asp:ListItem Value="3">Review</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>ID cửa hàng:</label>
                                <asp:TextBox runat="server" ID="txtShopCode" autocomplete="off" AutoCompleteType="Disabled" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>WorkId:</label>
                                <asp:TextBox runat="server" ID="txtWorkId" autocomplete="off" AutoCompleteType="Disabled" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-8">
                            <asp:Button runat="server" class="btn btn-primary" Text="Tìm kiếm" ID="btnFilter" OnClick="btnFilter_Click" />

                            <asp:Button runat="server"  class="btn btn-primary" Text="Xuất báo cáo" ID="btnExport" OnClick="btnExport_Click" UseSubmitBehavior="false" Style="float:right;" OnClientClick="this.value='Đang xuất file...'; this.disabled='true'" />
                            <asp:DropDownList runat="server" ID="ddlTypeReport" Style="width: 150px; height: 37px; float: right; margin-right: 20px;">
                                <asp:ListItem Text="ATTENDANT" Value="1000" />
                                <asp:ListItem Text="HOTZONE" Value="1" />
                                <asp:ListItem Text="OSA" Value="2" />
                                <asp:ListItem Text="POSM" Value="3" />
                                <asp:ListItem Text="PXN" Value="4" />
                                <asp:ListItem Text="SURVEY OTHER" Value="5" />
                                <asp:ListItem Text="Báo cáo chi tiết" Value="6" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-4" id="div_lockwr" runat="server" >
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:Label runat="server" ID="lbPassKeyWorkId" Visible="false" Text="@Kcul#323@"></asp:Label>
                                    <asp:TextBox CssClass="form-control" TextMode="Password" runat="server" ID="txtKeyWorkId" placeholder="PassWork"></asp:TextBox>
                                </div>
                                <div class="col-md-8">
                                    <asp:Button runat="server" ID="btnLockWrByWorkId" Text="Khóa B.Cáo + chạy c/thức theo WorkId" OnClick="btnLockWrByWorkId_Click" CssClass="btn btn-danger" />
                                </div>
                            </div>
                        </div>
                        <asp:Button ID="btnphoto" Visible="false" CssClass="button button-blue" OnClick="btnphoto_Click" runat="server" Text="Check Photo" />
                        <asp:HyperLink runat="server" Text="Check Photo" ID="hpExport" Visible="false"></asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content" id="workresult" runat="server" visible="false">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Kết quả làm việc</h3>

                        </div>
                        <div class="card-body" style="padding: 0 !important;">
                            <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>#</th>
                                                    <th>WorkId</th>
                                                    <th>Loại hình</th>
                                                    <th>Cửa hàng</th>
                                                    <th>Địa chỉ</th>
                                                    <th>Gói TB</th>
                                                    <th>Nhân viên</th>
                                                    <th>Ngày viếng thăm</th>
                                                    <th>KQ Làm việc</th>
                                                    <th>Điểm TB</th>
                                                    <th>% Trả thưởng</th>
                                                    <th>KQ QC</th>
                                                    <%--<th>Ghi chú</th>--%>
                                                    <th>Ngày App</th>
                                                    <th>Ngày hệ thống</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="rpWorkResult">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <asp:ImageButton ID="img" ImageUrl="~/images/plus.png" runat="server" OnClick="img_Click" CommandName="Show" Width="13" />
                                                            </td>
                                                            <td><%# Eval("RN") %></td>
                                                            <td>
                                                                <asp:Label Text='<%# Eval("WorkId") %>' runat="server" ID="lblWorkId" />
                                                                <img src='<%# "../images/"+Eval("Platform") +".svg" %>'></img>
                                                                (V:<%# Eval("Version") %>)
                                                                <asp:Label Text='<%# Eval("IsLockReport") %>' Visible="false" runat="server" ID="lbIsLockReport" />
                                                                <asp:Label Text='<%# Eval("QCStatus") %>' Visible="false" runat="server" ID="lbQCStatus" />
                                                                <asp:Label Text='<%# Eval("IsNewShop") %>' Visible="false" runat="server" ID="lbIsNewShop" />
                                                            </td>
                                                            <td><%# Eval("ShopType") %></td>
                                                            <td><%# Eval("ShopId") %> - <%# Eval("ShopName") %></td>
                                                            <td><%# Eval("AddressLine") %></td>
                                                            <td><%--<%# Eval("PNG") %>--%>
                                                                <asp:Label runat="server" ID="Label11111" CssClass='<%# Eval("PNG_BCOLOR") %>' Text='<%# Eval("PNG") %>'></asp:Label>
                                                            </td>
                                                            <td><%# Eval("EmployeeId") %> - <%# Eval("EmployeeName") %></td>
                                                            <td>
                                                                <asp:Label Text='<%# Eval("AuditDate") %>' runat="server" ID="lblAuditDate" />
                                                                <asp:Label Text='<%# Eval("ShopId") %>' runat="server" ID="lblShopId" Visible="false" />
                                                                <asp:Label Text='<%# Eval("EmployeeId") %>' runat="server" ID="lblEmployeeId" Visible="false" />
                                                            </td>
                                                            <td><%--<%# Eval("AuditResult") %>--%>
                                                                <asp:Label runat="server" ID="lbVisitResult" CssClass='<%# Eval("AuditResult").ToString().Contains("KTC")?"badge bg-danger":"" %>' Text='<%# Eval("AuditResult") %>'></asp:Label>
                                                                <%#(Eval("Comment") != null && Eval("Comment").ToString() != "")?
                                                                                                                        "<i style='margin-left:6px;' title='"+Eval("Comment")+"' class='far fa-comments'></i>"
                                                                                                                        :"" %>
                                                            </td>
                                                            <td><%# Eval("StoreCard") %></td>
                                                            <td><%# Eval("PaymentPercent") %></td>
                                                            <td><%# Eval("QCStatusName") + "-" + Eval("QCActual") + "/" + Eval("QCTarget") %> </td>
                                                            <td><%# String.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("CreateDateApp")) %></td>
                                                            <td><%# String.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("CreateDateSys")) %></td>
                                                        </tr>
                                                        <asp:PlaceHolder ID="pndetail" Visible="false" runat="server">
                                                            <tr style="height: 40%">
                                                                <td colspan="100%" style="padding: 0px !important;">
                                                                    <%-- Tabs --%>
                                                                    <div class="card card-primary card-outline card-tabs">
                                                                        <div class="card-header p-0 pt-1 border-bottom-0">
                                                                            <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                                                                                <li class="nav-item" runat="server" id="li_att">
                                                                                    <asp:LinkButton runat="server" class="nav-link active" CommandName="ATT" ID="lbATT" OnClick="lbKPI_Click">Chấm công </asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_hotzone">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="Hotzone" ID="lbHotzone" OnClick="lbKPI_Click">Hot Zone </asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_png">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="Planogram" ID="lbPlanogram" OnClick="lbKPI_Click">Planogram</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_posm">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="POSM" ID="lbPOSM" OnClick="lbKPI_Click">POSM</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_promotion">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="PROMOTION" ID="lbPROMOTION" OnClick="lbKPI_Click">CTKM</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_surveyother">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SURVEYALL" ID="lbSURVEYALL" OnClick="lbKPI_Click">Khảo sát khác</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_createshop" visible="false">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="CTEATESHOP" ID="lbCREATESHOP" OnClick="lbKPI_Click">Tạo mới cửa hàng </asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_pxn">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="PXN" ID="lbPXN" OnClick="lbKPI_Click">Phiếu xác nhận</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_inposm">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="INPOSM" ID="lbINPOSM" OnClick="lbKPI_Click">Lắp đặt POSM</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_COMPE">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="COMPE" ID="lbCOMPE" OnClick="lbKPI_Click">Đối thú</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_SO">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SO" ID="lbSO" OnClick="lbKPI_Click">Bán hàng</asp:LinkButton>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                    <asp:Panel runat="server" ID="pnGrid" Visible="false">
                                                                        <%-- Audio --%>
                                                                        <asp:Panel runat="server" ID="plAudio" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-12">
                                                                                    <table width="100%">
                                                                                        <asp:Repeater runat="server" ID="rptAudio">
                                                                                            <ItemTemplate>
                                                                                                <audio controls="controls" style="width: 400px">
                                                                                                    <source src='<%# Eval("AudioPath") %>'>
                                                                                                </audio>
                                                                                            </ItemTemplate>
                                                                                        </asp:Repeater>
                                                                                    </table>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>

                                                                        <%-- Tab Attendant --%>
                                                                        <asp:Panel runat="server" ID="plATT" Visible="false">
                                                                            <div class="col-sm-11" style="height: 480px; overflow-y: scroll;">
                                                                                <table class="table table-bordered">
                                                                                    <tr style="text-align: left; vertical-align: top">
                                                                                        <thead>
                                                                                            <tr>
                                                                                                <th class="text-center">Check In</th>
                                                                                                <th class="text-center">Check Out</th>
                                                                                                <th class="text-center">Thời gian tại cửa hàng</th>
                                                                                                <th class="text-center">Overview</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody>
                                                                                            <asp:Repeater runat="server" ID="rptAttendant">
                                                                                                <ItemTemplate>
                                                                                                    <tr style="text-align: center;">
                                                                                                        <td>
                                                                                                            <%-- <asp:Label runat="server" ID="lblInTime" Text='<%# Eval("InTime") %>' />--%>
                                                                                                            <%# Eval("InTime") %>
                                                                                                            <br />
                                                                                                            Tọa độ: <%# Convert.ToString(Eval("LatitudeIn")) + " - "+ Convert.ToString(Eval("LongitudeIn")) %>
                                                                                                            <%-- <asp:Label runat="server" ID="lblLatLongIn" Text='<%# Convert.ToString(Eval("LatitudeIn")) + " - "+ Convert.ToString(Eval("LongitudeIn")) %>' />--%>
                                                                                                            <%--13.1984159 108.6861718--%>
                                                                                                            <br />
                                                                                                            Sai số(mét):<%# Eval("AccuracyIn") %>
                                                                                                            <%--<asp:Label runat="server" ID="lblAccurancyIn" Text='<%# Eval("AccuracyIn") %>' />--%>
                                                                                                            <br />
                                                                                                            <a onclick="return openNewImage('<%# Eval("Image_CheckIn") %>','<%# Eval("ShopId") %>', '0')">
                                                                                                                <img src='<%# Eval("Image_CheckIn") %>' style="width: 235px; height: 300px;" /></a>
                                                                                                            <%--<asp:ImageButton  ImageUrl='<%# Eval("Image_CheckIn") %>' runat="server" Width="235" Height="300" ID="imgInTime1" />--%>    
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <%# Eval("OutTime") %>
                                                                                                            <%--<asp:Label runat="server" ID="lblOutTime" Text='<%# Eval("OutTime") %>' />--%>
                                                                                                            <br />
                                                                                                            Tọa độ: 
                                                                                                           
                                                                                                            <%# Convert.ToString(Eval("LatitudeOut")) + " - "+ Convert.ToString(Eval("LongitudeOut")) %>
                                                                                                            <%--<asp:Label runat="server" ID="lblLatLongOut" Text='<%# Convert.ToString(Eval("LatitudeOut")) + " - "+ Convert.ToString(Eval("LongitudeOut")) %>' />--%>
                                                                                                            <br />
                                                                                                            Sai số(mét): 
                                                                                                           
                                                                                                            <%# Eval("AccuracyOut") %>
                                                                                                            <%--<asp:Label runat="server" ID="lblAccurancyOut" Text='<%# Eval("AccuracyOut") %>' />--%>
                                                                                                            <br />
                                                                                                            <a onclick="return openNewImage('<%# Eval("Image_CheckOut") %>','<%# Eval("ShopId") %>', '0')">
                                                                                                                <img src='<%# Eval("Image_CheckOut") %>' style="width: 235px; height: 300px;" /></a>
                                                                                                            <%--<asp:Image ImageUrl='<%# Eval("Image_CheckOut") %>' runat="server" Width="235" Height="300" ID="imgOutTime" />--%>
                                                                                                        </td>
                                                                                                        <td style="vertical-align: bottom;"><%# Eval("TotalHours") %>
                                                                                                            <br />
                                                                                                            <a title="Xem bản đồ" style="cursor: pointer" onclick="popWindow('<%# "https://www.google.com/maps/search/" + Convert.ToString(Eval("LatitudeOverview")) + "+" + Convert.ToString(Eval("LongitudeOverview")) %>', 820, 635)">
                                                                                                                <img style="border: 1px solid red; height: 300px" src='<%# "https://maps.googleapis.com/maps/api/staticmap?center=" + Convert.ToString(Eval("LatitudeOverview")) + "," + Convert.ToString(Eval("LongitudeOverview")) +"&zoom=15&size=300x300&maptype=roadmap&markers=color:red%7Clabel:Shop%7C" + Convert.ToString(Eval("LatitudeOverview")) + "," + Convert.ToString(Eval("LongitudeOverview")) +"&key=AIzaSyAa8HeLH2lQMbPeOiMlM9D1VxZ7pbGQq8o" %>' />
                                                                                                            </a>
                                                                                                        </td>
                                                                                                        <td><%# Eval("OverviewTime") %>
                                                                                                            <%--<asp:Label runat="server" ID="lblTimeOverview" Text='<%# Eval("OverviewTime") %>' />--%>
                                                                                                            <br />
                                                                                                            Tọa độ:<%# Convert.ToString(Eval("LatitudeOverview")) + " - "+ Convert.ToString(Eval("LongitudeOverview")) %>
                                                                                                            <%--<asp:Label runat="server" ID="lblLatLongStore" Text='<%# Convert.ToString(Eval("LatitudeOverview")) + " - "+ Convert.ToString(Eval("LongitudeOverview")) %>' />--%>
                                                                                                            <br />
                                                                                                            Sai số(mét): <%# Eval("AccuracyOverview") %>

                                                                                                            <%--<asp:Label runat="server" ID="lblAccurancyOverview" Text='<%# Eval("AccuracyOverview") %>' />--%>
                                                                                                            <br />
                                                                                                            <a onclick="return openNewImage('<%# Eval("Image_Overview") %>','<%# Eval("ShopId") %>', '0')">
                                                                                                                <img src='<%# Eval("Image_Overview") %>' style="width: 235px; height: 300px;" /></a>
                                                                                                            <%--<asp:Image runat="server" Width="235" Height="300" ID="imgOverview" ImageUrl='<%# Eval("Image_Overview") %>' />--%>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </ItemTemplate>
                                                                                            </asp:Repeater>
                                                                                        </tbody>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <%-- Tab Hotzone --%>
                                                                        <asp:Panel runat="server" ID="plHotzone" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Khảo sát</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>KQ Admin</th>
                                                                                                    <th class="text-center" <%# IsViewDataAuditer ==true ?"''": "style='display:none'"  %>>KQ Auditer</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptHotzone">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("SurveyName") %></td>
                                                                                                            <td style="text-align: center;"><%--<%# Convert.ToString(Eval("AnswerName")) %>--%>
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_1_" + Eval("SurveyId")%>'><%# Eval("AnswerName") %></span>

                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>
                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")?
                                                                                                                        "<input style='width:150px;' class='edit_textbox' id='"+Eval("WorkId") +"_1_"+ Eval("SurveyId")+"' data-valueold='"+Eval("BMValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='1' data-itemid='"+Eval("SurveyId")+"' min='0' max='1' value='"+Eval("BMValue")+"' type='number' placeholder='Nhập số 0 or 1' />"
                                                                                                                        :"" %>
                                                                                                                <asp:Label runat="server" Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") %>' ID="Label3211" Text='<%# Eval("BMValue") %>'></asp:Label>
                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAuditer ==true ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %>>
                                                                                                                <%# Eval("AuditValue") %>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-sm-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto.aspx?WorkId=<%# Eval("WorkId") %>&KPIId=1" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <%-- Tab Planogram --%>
                                                                        <asp:Panel runat="server" ID="plPlanogram" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-7" style="height: 550px; overflow-y: scroll">
                                                                                    <%--<table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">KPI</th>
                                                                                                    <th class="text-center">Chỉ tiêu</th>
                                                                                                    <th class="text-center">Thực tế</th>
                                                                                                    <th class="text-center">%</th>
                                                                                                    <th class="text-center">StoreCard</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>StoreCard Admin</th>
                                                                                                    <th class="text-center" <%# IsViewDataAuditer ==true ?"''": "style='display:none'"  %>>StoreCard Auditer</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rpt_calculator">
                                                                                                    <ItemTemplate>
                                                                                                        <tr <%# Eval("RN")==null || Eval("RN").ToString() == ""  ? "style='font-weight:bold;background-color:aquamarine;'": "''" %>>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: left;"><%# Eval("KPI") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("Target") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("Actual") %></td>
                                                                                                            <td><%# Eval("Percent") %></td>
                                                                                                            <td><%# Eval("StoreCard") %></td>
                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>

                                                                                                                <span <%# Eval("BM_StoreCard") !=null && Eval("BM_StoreCard").ToString() != Eval("Audit_StoreCard").ToString()  ? "class='badge bg-danger'": "''"%>><%# Eval("BM_StoreCard") %></span>
                                                                                                            </td>
                                                                                                            <td <%# IsViewDataAuditer ==true ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %>>
                                                                                                                <%# Eval("Audit_StoreCard") %>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>--%>
                                                                                    <table class="table table-bordered" <%# Eval("ShopType").ToString() == "GT" ? "style='display:none'" : "''" %>>
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center" rowspan="2" style="vertical-align: inherit;">SP OOS</th>
                                                                                                    <th class="text-center" colspan="2">System Francia</th>
                                                                                                    <th class="text-center" colspan="2">Audit</th>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <th class="text-center">Số SP KD	</th>
                                                                                                    <th class="text-center">Tỉ lệ OOS	</th>
                                                                                                    <th class="text-center">Số SP KD	</th>
                                                                                                    <th class="text-center">Tỉ lệ OOS</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rpt_calculator">
                                                                                                    <ItemTemplate>
                                                                                                        <td class="text-center"><%# Eval("TotalOOS") %></td>
                                                                                                        <td class="text-center"><%# Eval("TotalFA") %></td>
                                                                                                        <td class="text-center"><%# Eval("PercentFA") %> %</td>
                                                                                                        <td class="text-center"><%# Eval("TotalAudit") %></td>
                                                                                                        <td class="text-center"><%# Eval("PercentAudit") %> %</td>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                                <%--<tr>
                                                                                                    <td class="text-center">25</td>
                                                                                                    <td class="text-center">26</td>
                                                                                                    <td class="text-center">96%</td>
                                                                                                    <td class="text-center">29</td>
                                                                                                    <td class="text-center">86%</td>
                                                                                                </tr>--%>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>


                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Nhãn hàng</th>
                                                                                                    <th class="text-center">Sản phẩm</th>
                                                                                                    <th class="text-center">Tiêu chí FA</th>
                                                                                                    <th class="text-center">Số mặt| 
                                                                                                        <asp:CheckBox runat="server" ID="cbAllOSA" Text="Tất cả" Checked="true" AutoPostBack="true" OnCheckedChanged="cbAllOSA_CheckedChanged" /></th>
                                                                                                    <th <%# Eval("ShopType").ToString() == "GT" ? "style='display:none'" : "''" %>>Số lớp</th>
                                                                                                    <th <%# Eval("ShopType").ToString() == "GT" ? "style='display:none'" : "''" %>>Số chân</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>T/tế Admin (SM,SL,SC)</th>
                                                                                                    <th class="text-center" <%# IsViewDataAuditer ==true ?"''": "style='display:none'"  %>>T/tế Auditer (SM,SL,SC)  </th>

                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptOSA">
                                                                                                    <ItemTemplate>
                                                                                                        <tr <%# Convert.ToInt32(Eval("RN")) != 1 ? "style='display:none'" : "''" %>>
                                                                                                            <td colspan="5" style="font-size: 18px; color: chocolate; text-align: left;"><%# Eval("KeyBrand") %></td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td style="text-align: left;"><%# Eval("RN_List") %></td>
                                                                                                            <td style="text-align: left;"><%# Eval("Brand") %>
                                                                                                            <td style="text-align: left;"><%# Eval("ProductId") %> - <%# Eval("ProductDescription") %>
                                                                                                                <a style='<%# Eval("Picture") == null || Eval("Picture").ToString() =="" ?"display:none": "" %>' onclick="return openNewImage('<%# Eval("Picture") %>','<%# Eval("WorkId") %>', '-2')" class="ad-active"><i class="fas fa-eye"></i></a>
                                                                                                            </td>
                                                                                                            <td style="text-align: center; color: red;"><%# Eval("OSATarget") %>
                                                                                                            <td style="text-align: center;">
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_2_" + Eval("ProductId")%>' class='<%# Eval("OSAValue").ToString().Contains("KĐạt") || Eval("OSAValue").ToString()=="0"?"badge bg-danger":"" %>'><%# Eval("OSAValue") %></span>
                                                                                                            </td>
                                                                                                            <td <%# Eval("ShopType").ToString() == "GT" ? "style='display:none'" : "''" %>><%# Eval("LayerValue") %></td>
                                                                                                            <td <%# Eval("ShopType").ToString() == "GT" ? "style='display:none'" : "''" %>><%# Eval("ShowFootValue").ToString() =="1"? Eval("FootValue"):"" %></td>
                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;display:table-cell;'": "style='display:none;'" %>>
                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")
                                                                                                                         ?"<input class='edit_textbox' id='"+Eval("WorkId") +"_2_" + Eval("ProductId")+"' data-valueold='"+Eval("BM_OSAValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='2' data-itemid='"+Eval("ProductId")+"' min='0' max='99' style='width:105px;' value='"+Eval("BM_OSAValue")+"' type='number' placeholder='"+ (Eval("Brand").Equals("SURVEY") ?"Nhập =0 or =1":"SM>=0,<100")+"'  />"
                                                                                                                         :"" %>

                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5" && Eval("ShopType").ToString() == "MT")
                                                                                                                         ?"<br /><input class='edit_textbox' id='"+Eval("WorkId") +"_200_" + Eval("ProductId")+"' data-valueold='"+Eval("BM_LayterValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='200' data-itemid='"+Eval("ProductId")+"' min='0' max='99' style='width:105px;' value='"+Eval("BM_LayterValue")+"' type='number' placeholder='"+ (Eval("Brand").Equals("SURVEY") ?"Nhập =0 or =1":"SL>=0,<100")+"'  />"
                                                                                                                         :"" %>
                                                                                                                <%#(Eval("ShowFootValue").ToString() =="1"  && IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5" && Eval("ShopType").ToString() == "MT")
                                                                                                                         ?"<br /><input class='edit_textbox' id='"+Eval("WorkId") +"_201_" + Eval("ProductId")+"' data-valueold='"+Eval("BM_FootValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='201' data-itemid='"+Eval("ProductId")+"' min='0' max='99' style='width:105px;' value='"+Eval("BM_FootValue")+"' type='number' placeholder='"+ (Eval("Brand").Equals("SURVEY") ?"Nhập =0 or =1":"SC>=0,<100")+"'  />"
                                                                                                                         :"" %>
                                                                                                                <%--<input class="edit_textbox" id='<%#Eval("WorkId") +"_2_" + Eval("ProductId")%>' data-valueold='<%#Eval("BM_OSAValue")%>' data-workid='<%#Eval("WorkId")%>' data-kpiid='2' data-itemid='<%#Eval("ProductId")%>' min="0" max="99" <%# IsEditDataAdmin ==true && Eval("IsLockReport").ToString()=="0" ?"style='width:150px;'": "style='display:none;text-align: center;'"  %> value='<%# Eval("BM_OSAValue") %>' type="number" <%# Eval("Brand").Equals("SURVEY") ?"placeholder='Nhập số =0 or =1'": "placeholder='Nhập số >=0,<100'"  %> />--%>
                                                                                                                <span <%# IsViewDataAdmin ==true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5" ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %> class='<%# Eval("BM_OSAValue").ToString().Contains("KĐạt") || Eval("BM_OSAValue").ToString().Contains("0")?"badge bg-danger":"" %>'>SM:<%# Eval("BM_OSAValue") %></span>
                                                                                                                <span <%# Eval("ShopType").ToString() == "MT" && (IsViewDataAdmin ==true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %> class='<%# Eval("BM_LayterValue").ToString().Contains("KĐạt") || Eval("BM_LayterValue").ToString().Contains("0")?"badge bg-danger":"" %>'>;SL:<%# Eval("BM_LayterValue") %></span>
                                                                                                                <span <%# Eval("ShopType").ToString() == "MT" && Eval("ShowFootValue").ToString() =="1" && (IsViewDataAdmin ==true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %> class='<%# Eval("BM_FootValue").ToString().Contains("KĐạt") || Eval("BM_FootValue").ToString().Contains("0")?"badge bg-danger":"" %>'>;SC:<%# Eval("BM_FootValue") %></span>
                                                                                                            </td>
                                                                                                            <td <%# IsViewDataAuditer ==true ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %>>
                                                                                                                <span class='<%# Eval("Audit_OSAValue").ToString().Contains("KĐạt") || Eval("Audit_OSAValue").ToString()=="0"?"badge bg-danger":"" %>'>SM:<%# Eval("Audit_OSAValue") %></span>
                                                                                                                <span <%# Eval("ShopType").ToString() == "GT" ?"style='display:none;'": ""  %> class='<%# Eval("Audit_LayerValue").ToString().Contains("KĐạt") || Eval("Audit_LayerValue").ToString()=="0"?"badge bg-danger":"" %>'>;SL:<%# Eval("Audit_LayerValue") %></span>
                                                                                                                <span <%# Eval("ShowFootValue").ToString() =="0" || Eval("ShopType").ToString() == "GT" ?"style='display:none;'": ""  %> class='<%# Eval("Audit_FootValue").ToString().Contains("KĐạt") || Eval("Audit_FootValue").ToString()=="0"?"badge bg-danger":"" %>'>;SC:<%# Eval("Audit_FootValue") %></span>
                                                                                                            </td>

                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-5">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto.aspx?WorkId=<%# Eval("WorkId") %>&KPIId=2" frameborder='0' frameborder='0' scrolling='yes' width='650px' height='540px'></iframe>
                                                                                        <%--<input <%# IsEditDataAdmin ==true ?"''": "style='display:none;'"  %> type="button" class="btn btn-danger" value="Thêm Hình" />--%>
                                                                                    </div>

                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>

                                                                        <%-- Tab POSM --%>
                                                                        <asp:Panel runat="server" ID="plPOSM" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">POSM</th>
                                                                                                    <th class="text-center">Chỉ tiêu</th>
                                                                                                    <th class="text-center">Thực tế</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>Thực tế Admin</th>
                                                                                                    <th class="text-center" <%# IsViewDataAuditer ==true ?"''": "style='display:none'"  %>>Thực tế Auditer</th>
                                                                                                    <th class="text-center">T/Thái</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptPOSM">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("PosmId") %> - <%# Eval("PosmName") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("Target") %></td>
                                                                                                            <td style="text-align: center;"><span id='<%# "lb_"+Eval("WorkId") +"_3_" + Eval("PosmId")%>' class='<%# Convert.ToInt32( Eval("Value")) >= Convert.ToInt32( Eval("Target")) ?"":"badge bg-danger" %>'><%# Eval("Value") %></span>

                                                                                                                <%#(Eval("Comment") != null && Eval("Comment").ToString() != "")?
                                                                                                                        "<i style='margin-left:6px;' title='"+Eval("Comment")+"' class='far fa-comments'></i>"
                                                                                                                        :"" %>
                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>
                                                                                                                <%--<input class="edit_textbox" id='<%#Eval("WorkId") +"_3_" + Eval("PosmId")%>' data-valueold='<%#Eval("BM_Quantity")%>' data-workid='<%#Eval("WorkId")%>' data-kpiid='3' data-itemid='<%#Eval("PosmId")%>' min="0" max="99" <%# IsEditDataAdmin ==true && Eval("IsLockReport").ToString()=="0" ?"style='width:150px;'": "style='display:none;text-align: center;'"  %> value='<%# Eval("BM_Quantity") %>' type="number" <%#"placeholder='Nhập số >=0,<=10'"  %> />--%>

                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")?
                                                                                                                        "<input style='width:150px;' class='edit_textbox' id='"+Eval("WorkId") +"_3_"+ Eval("PosmId")+"' data-valueold='"+Eval("BM_Quantity")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='3' data-itemid='"+Eval("PosmId")+"' min='0' max='99' value='"+Eval("BM_Quantity")+"' type='number' placeholder='Nhập số >=0,<=50' />"
                                                                                                                        :"" %>
                                                                                                                <asp:Label runat="server" Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") %>' ID="Label322" Text='<%# Eval("BM_Quantity") %>'></asp:Label>
                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAuditer ==true ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %>>
                                                                                                                <%# Eval("Audit_Quantity") %>
                                                                                                            </td>
                                                                                                            <td><span class='<%# Eval("Status").ToString().Contains("2")?"badge bg-danger":"" %>'><%# Eval("StatusName") %></span></td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto.aspx?WorkId=<%# Eval("WorkId") %>&KPIId=3" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='540px'></iframe>
                                                                                        <%--<input <%# IsEditDataAdmin ==true ?"''": "style='display:none;'"  %> type="button" class="btn btn-danger" value="Thêm Hình" />--%>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <%-- Tab Promotion --%>
                                                                        <asp:Panel runat="server" ID="plPROMOTION" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">CTKM</th>
                                                                                                    <th class="text-center">Có</th>
                                                                                                    <th class="text-center">Có tag giảm giá</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>Có/Không Admin</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>Tag GG Admin</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptPROMOTION">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("PromotionId") %> - <%# Eval("PromotionName") %></td>
                                                                                                            <td style="text-align: center;"><span id='<%# "lb_"+Eval("WorkId") +"_7_" + Eval("PromotionId")%>' class='<%# Convert.ToInt32( Eval("Value")) >= Convert.ToInt32( Eval("Target")) ?"":"badge bg-danger" %>'><%# Eval("Value") %></span>

                                                                                                                <%#(Eval("Comment") != null && Eval("Comment").ToString() != "")?
                                                                                                                        "<i style='margin-left:6px;' title='"+Eval("Comment")+"' class='far fa-comments'></i>"
                                                                                                                        :"" %>
                                                                                                            </td>
                                                                                                            <td style="text-align: center;">
                                                                                                                <%# Eval("Value1") %>
                                                                                                            </td>
                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>
                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")?
                                                                                                                        "<input style='width:150px;' class='edit_textbox' id='"+Eval("WorkId") +"_7_"+ Eval("PromotionId")+"' data-valueold='"+Eval("BMValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='7' data-itemid='"+Eval("PromotionId")+"' min='0' max='1' value='"+Eval("BMValue")+"' type='number' placeholder='Nhập số >=0,<=1' />"
                                                                                                                        :"" %>
                                                                                                                <asp:Label runat="server" Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") %>' ID="Label3222" Text='<%# Eval("BMValue") %>'></asp:Label>
                                                                                                            </td>
                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>
                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")?
                                                                                                                        "<input style='width:150px;' class='edit_textbox' id='"+Eval("WorkId") +"_700_"+ Eval("PromotionId")+"' data-valueold='"+Eval("BMValue1")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='700' data-itemid='"+Eval("PromotionId")+"' min='0' max='1' value='"+Eval("BMValue1")+"' type='number' placeholder='Nhập số >=0,<=1' />"
                                                                                                                        :"" %>
                                                                                                                <asp:Label runat="server" Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") %>' ID="Label153" Text='<%# Eval("BMValue1") %>'></asp:Label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto.aspx?WorkId=<%# Eval("WorkId") %>&KPIId=7" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='540px'></iframe>
                                                                                        <%--<input <%# IsEditDataAdmin ==true ?"''": "style='display:none;'"  %> type="button" class="btn btn-danger" value="Thêm Hình" />--%>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <%-- Tab Survey Other --%>
                                                                        <asp:Panel runat="server" ID="plSURVEYALL" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Khảo sát</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>KQ Admin</th>
                                                                                                    <th class="text-center" <%# IsViewDataAuditer ==true ?"''": "style='display:none'"  %>>KQ Auditer</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptSURVEYALL">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("SurveyName") %></td>
                                                                                                            <td style="text-align: center; max-width: 200px;"><%--<%# Convert.ToString(Eval("AnswerName")) %>--%>
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_5_" + Eval("SurveyId")%>'><%# Eval("AnswerName") %></span>
                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>
                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")?
                                                                                                                        "<input style='width:200px;' class='edit_textbox' id='"+Eval("WorkId") +"_5_"+ Eval("SurveyId")+"' data-valueold='"+Eval("BMTextValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='5' data-itemid='"+Eval("SurveyId")+"' min='0' max='1' value='"+Eval("BMTextValue")+"' type='text' placeholder='Ghi chú' />"
                                                                                                                        :"" %>
                                                                                                                <asp:Label runat="server" Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") %>' ID="Label3211" Text='<%# Eval("BMValue") %>'></asp:Label>
                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAuditer ==true ?"style='text-align: center;max-width:200px;'": "style='display:none;max-width:200px;'"  %>>
                                                                                                                <%# Eval("AuditTextValue") %>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto.aspx?WorkId=<%# Eval("WorkId") %>&KPIId=5" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <%-- Tab PNX --%>
                                                                        <asp:Panel runat="server" ID="plPXN" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Khảo sát</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>KQ Admin</th>
                                                                                                    <th class="text-center" <%# IsViewDataAuditer ==true ?"''": "style='display:none'"  %>>KQ Auditer</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptPRO">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("SurveyName") %></td>
                                                                                                            <td style="text-align: center;"><%--<%# Convert.ToString(Eval("AnswerName")) %>--%>
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_4_" + Eval("SurveyId")%>'><%# Eval("AnswerName") %></span>

                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>
                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")?
                                                                                                                        "<input style='width:150px;' class='edit_textbox' id='"+Eval("WorkId") +"_4_"+ Eval("SurveyId")+"' data-valueold='"+Eval("BMValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='4' data-itemid='"+Eval("SurveyId")+"' min='0' max='1' value='"+Eval("BMValue")+"' type='number' placeholder='Nhập số 0 or 1' />"
                                                                                                                        :"" %>
                                                                                                                <asp:Label runat="server" Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") %>' ID="Label3211" Text='<%# Eval("BMValue") %>'></asp:Label>
                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAuditer ==true ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %>>
                                                                                                                <%# Eval("AuditValue") %>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto.aspx?WorkId=<%# Eval("WorkId") %>&KPIId=4" frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>

                                                                        <asp:Panel runat="server" ID="plCTEATESHOP" Visible="false">
                                                                            <div class="col-sm-11" style="height: 480px; overflow-y: scroll;">
                                                                                <table class="table table-bordered">
                                                                                    <tr style="text-align: left; vertical-align: top">
                                                                                        <thead>
                                                                                            <tr>
                                                                                                <th class="text-center">Thông tin</th>
                                                                                                <th class="text-center">Hình ảnh</th>
                                                                                                <th class="text-center">Ảnh Google Map</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody>
                                                                                            <asp:Repeater runat="server" ID="rpt_cshop">
                                                                                                <ItemTemplate>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <table style="width: 100%;">
                                                                                                                <tr>
                                                                                                                    <td style="font-weight: bold;">Tên chủ CH</td>
                                                                                                                    <td><%# Eval("merchantName") %></td>
                                                                                                                    <td style="font-weight: bold;">Số điện thoại</td>
                                                                                                                    <td><%# Eval("phoneNumber") %></td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td style="font-weight: bold;">Biển số xe</td>
                                                                                                                    <td colspan="3"><%# Eval("addressline") %></td>
                                                                                                                </tr>
                                                                                                                <%--<tr>
                                                                                                                    <td style="font-weight: bold;">Phường/xã</td>
                                                                                                                    <td><%# Eval("town") %></td>
                                                                                                                    <td style="font-weight: bold;">Quận/Huyện</td>
                                                                                                                    <td><%# Eval("district") %></td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td style="font-weight: bold;">Tỉnh/Thành Phố</td>
                                                                                                                    <td><%# Eval("province") %></td>
                                                                                                                    <td style="font-weight: bold;">Diện tích TB(met)</td>
                                                                                                                    <td><%# Eval("areaDisplay") %></td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td style="font-weight: bold;">Mặt hàng trưng bày</td>
                                                                                                                    <td><%# Eval("itemDisplay") %></td>
                                                                                                                    <td style="font-weight: bold;">Đăng ký CTTB</td>
                                                                                                                    <td><%# Eval("typeDisplay") %></td>
                                                                                                                </tr>--%>
                                                                                                                <tr>
                                                                                                                    <%-- <td style="font-weight: bold;">Doanh thu ( triệu)</td>
                                                                                                                    <td><%# Eval("revenue") %></td>--%>
                                                                                                                    <td style="font-weight: bold;">Tọa độ</td>
                                                                                                                    <td><%# Convert.ToString(Eval("latitude")) + " "+ Convert.ToString(Eval("longitude")) %></td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                        <td style="text-align: center;">
                                                                                                            <%--<img src='<%# Eval("photo") %>' style="height: 300px;" />--%>
                                                                                                            <%# load_image_create_Shop(Eval("photo").ToString()) %>
                                                                                                        </td>
                                                                                                        <td style="text-align: center;">
                                                                                                            <a title="Xem bản đồ" style="cursor: pointer" onclick="popWindow('<%# "https://www.google.com/maps/search/" + Convert.ToString(Eval("latitude")) + "+" + Convert.ToString(Eval("longitude")) %>', 820, 635)">
                                                                                                                <img style="border: 1px solid red; height: 300px" src='<%# "https://maps.googleapis.com/maps/api/staticmap?center=" + Convert.ToString(Eval("latitude")) + "," + Convert.ToString(Eval("longitude")) +"&zoom=15&size=300x300&maptype=roadmap&markers=color:red%7Clabel:Shop%7C" + Convert.ToString(Eval("latitude")) + "," + Convert.ToString(Eval("longitude")) +"&key=AIzaSyAa8HeLH2lQMbPeOiMlM9D1VxZ7pbGQq8o" %>' />
                                                                                                            </a>
                                                                                                            <%--<img src="../Images/no_avatar.jpg" style="height: 300px;" />--%>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </ItemTemplate>
                                                                                            </asp:Repeater>
                                                                                        </tbody>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </asp:Panel>

                                                                        <%-- Tab INPOSM --%>
                                                                        <asp:Panel runat="server" ID="plINPOSM" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">POSM</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>KQ Admin</th>
                                                                                                    <th class="text-center" <%# IsViewDataAuditer ==true ?"''": "style='display:none'"  %>>KQ Auditer</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptINPOSM">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("SurveyName") %></td>
                                                                                                            <td style="text-align: center;"><%--<%# Convert.ToString(Eval("AnswerName")) %>--%>
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_4_" + Eval("SurveyId")%>'><%# Eval("AnswerName") %></span>

                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>
                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")?
                                                                                                                        "<input style='width:150px;' class='edit_textbox' id='"+Eval("WorkId") +"_4_"+ Eval("SurveyId")+"' data-valueold='"+Eval("BMValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='4' data-itemid='"+Eval("SurveyId")+"' min='0' max='1' value='"+Eval("BMValue")+"' type='number' placeholder='Nhập số 0 or 1' />"
                                                                                                                        :"" %>
                                                                                                                <asp:Label runat="server" Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") %>' ID="Label3211" Text='<%# Eval("BMValue") %>'></asp:Label>
                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAuditer ==true ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %>>
                                                                                                                <%# Eval("AuditValue") %>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto.aspx?WorkId=<%# Eval("WorkId") %>&KPIId=9" frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>

                                                                        <%-- Tab COMPE --%>
                                                                        <asp:Panel runat="server" ID="plCOMPE" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Đối thủ</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>KQ Admin</th>
                                                                                                    <th class="text-center" <%# IsViewDataAuditer ==true ?"''": "style='display:none'"  %>>KQ Auditer</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptCOMPE">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("SurveyName") %></td>
                                                                                                            <td style="text-align: center;"><%--<%# Convert.ToString(Eval("AnswerName")) %>--%>
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_4_" + Eval("SurveyId")%>'><%# Eval("AnswerName") %></span>

                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>
                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")?
                                                                                                                        "<input style='width:150px;' class='edit_textbox' id='"+Eval("WorkId") +"_4_"+ Eval("SurveyId")+"' data-valueold='"+Eval("BMValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='4' data-itemid='"+Eval("SurveyId")+"' min='0' max='1' value='"+Eval("BMValue")+"' type='number' placeholder='Nhập số 0 or 1' />"
                                                                                                                        :"" %>
                                                                                                                <asp:Label runat="server" Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") %>' ID="Label3211" Text='<%# Eval("BMValue") %>'></asp:Label>
                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAuditer ==true ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %>>
                                                                                                                <%# Eval("AuditValue") %>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto.aspx?WorkId=<%# Eval("WorkId") %>&KPIId=8" frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>

                                                                        <%-- Tab SO --%>
                                                                        <asp:Panel runat="server" ID="plSO" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Sản phẩm</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                    <th class="text-center" <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "''":"style='display:none'" %>>KQ Admin</th>
                                                                                                    <th class="text-center" <%# IsViewDataAuditer ==true ?"''": "style='display:none'"  %>>KQ Auditer</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptSO">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("SurveyName") %></td>
                                                                                                            <td style="text-align: center;"><%--<%# Convert.ToString(Eval("AnswerName")) %>--%>
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_4_" + Eval("SurveyId")%>'><%# Eval("AnswerName") %></span>

                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAdmin ==true || IsEditDataAdmin ==true  ? "style='text-align: center;'": "style='display:none;text-align: center;'" %>>
                                                                                                                <%#(IsEditDataAdmin == true && Eval("IsLockReport").ToString() == "0" && Eval("QCStatus").ToString() != "5")?
                                                                                                                        "<input style='width:150px;' class='edit_textbox' id='"+Eval("WorkId") +"_4_"+ Eval("SurveyId")+"' data-valueold='"+Eval("BMValue")+"' data-workid='"+Eval("WorkId")+"' data-kpiid='4' data-itemid='"+Eval("SurveyId")+"' min='0' max='1' value='"+Eval("BMValue")+"' type='number' placeholder='Nhập số 0 or 1' />"
                                                                                                                        :"" %>
                                                                                                                <asp:Label runat="server" Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1" || Eval("QCStatus").ToString() == "5") %>' ID="Label3211" Text='<%# Eval("BMValue") %>'></asp:Label>
                                                                                                            </td>

                                                                                                            <td <%# IsViewDataAuditer ==true ?"style='text-align: center;'": "style='display:none;text-align: center;'"  %>>
                                                                                                                <%# Eval("AuditValue") %>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto.aspx?WorkId=<%# Eval("WorkId") %>&KPIId=10" frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                    </asp:Panel>
                                                                    <br />
                                                                    <div class="row" <%# IsViewDataQC ==true || IsEditDataQC ==true ?"''": "style='display:none'"  %>>
                                                                        <div class="col-sm-6">
                                                                            <div class="card">
                                                                                <div class="card-header">
                                                                                    <%--<h3 class="card-title" style="color: red;">Kết quả KPI chấm công</h3>--%>
                                                                                    <asp:Label ID="lbqckpi" class="card-title" runat="server" Style="color: red;">Kết quả KPI</asp:Label>
                                                                                    <asp:Label ID="lbqckpiid" Visible="false" runat="server" Text="6"></asp:Label>
                                                                                    <asp:Label ID="lbqckpiname" runat="server" Visible="false"></asp:Label>
                                                                                </div>
                                                                                <div class="card-body">
                                                                                    <div class="row">
                                                                                        <div class="col-md-3">
                                                                                            <asp:DropDownList runat="server" ID="ddlQCKPI" Enabled='<%# Convert.ToBoolean(Eval("IsLockReport").ToString()=="0") %>' CssClass="form-control">
                                                                                                <asp:ListItem Value="0">--Chọn--</asp:ListItem>
                                                                                                <asp:ListItem Value="1">Pass</asp:ListItem>
                                                                                                <asp:ListItem Value="2">Reject</asp:ListItem>
                                                                                                <asp:ListItem Value="3">Review</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                            <br />
                                                                                            <asp:Button runat="server" Visible='<%# Convert.ToBoolean(IsEditDataQC == true && Eval("IsLockReport").ToString()=="0" && Eval("QCStatus").ToString()!="5") %>' ID="btnQCKPI" Style="width: 100%;" Text="Lưu KPI" CssClass="btn btn-primary" OnClick="btnQCKPI_Click" />

                                                                                        </div>
                                                                                        <div class="col-md-9">
                                                                                            <asp:TextBox runat="server" ID="txtQCKPIComment" Enabled='<%# Convert.ToBoolean(Eval("IsLockReport").ToString()=="0") %>' TextMode="MultiLine" Height="101px" placeholder="Ghi chú" CssClass="form-control">
                                                                                            </asp:TextBox>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row">
                                                                                        <div class="col-md-4">
                                                                                            <asp:Button runat="server" Visible='<%# Convert.ToBoolean(IsEditDataQC == true && Eval("IsLockReport").ToString()=="0" && Eval("QCStatus").ToString()!="5") %>' ID="btnChangeImage" Style="width: 100%;" Text="Thay đổi hình ảnh" CssClass="btn btn-secondary" />
                                                                                        </div>
                                                                                        <div class="col-md-8">
                                                                                            <asp:Button runat="server" Visible='<%# Convert.ToBoolean(IsEditDataQC == true && Eval("IsLockReport").ToString()=="0" && Eval("QCStatus").ToString()!="5") %>' ID="btnDoneQc" Style="width: 100%;" Text="Hoàn thành QC" CssClass="btn btn-danger" OnClick="btnDoneQc_Click" />
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="card-footer" style="display: none;">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-6" style="text-align: center;">
                                                                            <div class="card">
                                                                                <div class="card-header">
                                                                                    <h3 class="card-title" style="color: blue;">Kết quả báo cáo</h3>
                                                                                </div>
                                                                                <div class="card-body">
                                                                                    <div class="row">
                                                                                        <div class="col-md-3">
                                                                                            <asp:DropDownList runat="server" ID="ddlQC" CssClass="form-control" Enabled='<%# Convert.ToBoolean(Eval("IsLockReport").ToString()=="0") %>'>
                                                                                                <asp:ListItem Value="0">--Chọn--</asp:ListItem>
                                                                                                <asp:ListItem Value="1">Pass</asp:ListItem>
                                                                                                <asp:ListItem Value="2">Reject</asp:ListItem>
                                                                                                <asp:ListItem Value="3">Review</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </div>
                                                                                        <div class="col-md-9">
                                                                                            <asp:TextBox runat="server" Enabled='<%# Convert.ToBoolean(Eval("IsLockReport").ToString()=="0") %>' ID="txtQCComment" placeholder="Ghi chú" CssClass="form-control">
                                                                                            </asp:TextBox>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="card-footer">
                                                                                    <div class="row">
                                                                                        <div class="col-md-2">
                                                                                            <asp:Label runat="server" ID="lbPassKey" Visible="false" Text="@Kcul#323@"></asp:Label>
                                                                                            <asp:TextBox CssClass="form-control" TextMode="Password" runat="server" ID="txtKey" placeholder="PassWork"></asp:TextBox>
                                                                                        </div>
                                                                                        <div class="col-md-4">
                                                                                            <asp:Button runat="server" CommandArgument="-100" Visible='<%# Convert.ToBoolean(IsEditDataQC == true && Eval("IsLockReport").ToString()=="0" && Eval("QCStatus").ToString()=="5") %>' ID="btnLockWr" Text="Khóa B.Cáo + chạy c/thức tính điểm TB" OnClick="btnLockWr_Click" CssClass="btn btn-danger" />

                                                                                        </div>
                                                                                        <div class="col-md-4">
                                                                                            <asp:Button runat="server" CommandArgument="-101" Visible='<%# Convert.ToBoolean(IsEditDataQC == true && Eval("IsLockReport").ToString()=="0" && Eval("QCStatus").ToString()=="5") %>' ID="Button1" Text="Mở QC" OnClick="btnLockWr_Click" CssClass="btn btn-danger" />
                                                                                            <asp:Button runat="server" CommandArgument="-102" Visible='<%# Convert.ToBoolean(IsEditDataQC == true && Eval("IsLockReport").ToString()=="1") %>' ID="Button2" Text="Mở khóa BC" OnClick="btnLockWr_Click" CssClass="btn btn-danger" />
                                                                                            <%--<p style="color: red; font-weight: bold;">Lưu ý: Phải hoàn thành các KPI trước khi khóa B.Cáo.</p>--%>
                                                                                        </div>
                                                                                    </div>


                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </asp:PlaceHolder>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                        <asp:Panel runat="server" ID="plPaging" Visible="false">
                                            <div class="row">
                                                <div class="col-sm-12 col-md-5">
                                                    <div class="dataTables_info" id="example2_info" role="status" aria-live="polite">
                                                        Hiển thị
                                                        <asp:Label ID="lblFrom" runat="server" />
                                                        đến
                                                        <asp:Label ID="lblTo" runat="server" />
                                                        của 
                                                        <asp:Label ID="lblTotalRows" runat="server" />
                                                        dữ liệu
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 col-md-7" style="display: none;">
                                                    <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
                                                        <ul class="pagination">
                                                            <li class="paginate_button page-item previous" id="example2_previous">
                                                                <asp:LinkButton Text="Previous" runat="server" CssClass="page-link" ID="lnkPrevious" CommandName="Previous" OnClick="lnkPrevious_Click" />
                                                            </li>
                                                            <asp:Repeater runat="server" ID="rptPaging">
                                                                <ItemTemplate>
                                                                    <li class='<%# Eval("Active") %>'>
                                                                        <asp:LinkButton ID="lnkPage" Text='<%# Eval("PageNumber") %>' CommandName="Page" runat="server" CssClass="page-link" OnClick="lnkPage_Click" />
                                                                    </li>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                            <%--<li class="paginate_button page-item active"><a href="#" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>--%>
                                                            <li class="paginate_button page-item next" id="example2_next">
                                                                <asp:LinkButton Text="Next" runat="server" CssClass="page-link" ID="lnkNext" CommandName="Next" OnClick="lnkNext_Click" />
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 col-md-7">
                                                    <div class="dataTables_paginate paging_simple_numbers">
                                                        <ul class="pagination">
                                                            <li class="paginate_button page-item previous">
                                                                <asp:LinkButton
                                                                    CssClass="page-link" runat="server" ID="lbn_first" OnClick="lbn_first_Click"><i class="fa fa-angle-double-left"></i>
                                                                </asp:LinkButton>
                                                            </li>
                                                            <li class="paginate_button page-item previous" id="prv_button">
                                                                <asp:LinkButton
                                                                    CssClass="page-link" runat="server" ID="lbn_prev" OnClick="lbn_prev_Click"><i class="fa fa-angle-left"></i>
                                                                </asp:LinkButton>
                                                            </li>
                                                            <asp:Repeater ID="rpt_pagination" runat="server" OnItemCommand="rpt_pagination_ItemCommand">
                                                                <ItemTemplate>
                                                                    <li class='<%#Eval("Class")%>'>
                                                                        <asp:LinkButton
                                                                            CssClass="page-link" CommandName="Page" CommandArgument='<%#Eval("Page")%>' runat="server" Font-Bold="True"><%#Eval("Page")%>  
                                                                        </asp:LinkButton>
                                                                    </li>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                            <li class="paginate_button page-item next">
                                                                <asp:LinkButton
                                                                    CssClass="page-link" runat="server" ID="lbn_next" OnClick="lbn_next_Click"><i class="fa fa-angle-right"></i>
                                                                </asp:LinkButton>
                                                            </li>
                                                            <li class="paginate_button page-item previous">
                                                                <asp:LinkButton
                                                                    CssClass="page-link" runat="server" ID="lbn_end" OnClick="lbn_end_Click"><i class="fa fa-angle-double-right"></i>
                                                                </asp:LinkButton>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        var requestManager = Sys.WebForms.PageRequestManager.getInstance();
        requestManager.add_endRequest(function () {
            //Loading();
        });
        requestManager.add_endRequest(function () {
            //EndLoading();
            edit_textbox();
        });
    </script>
    <script>
        function popWindow(link, width, height) {
            var w = width, h = height;
            var left = (screen.width / 2) - (w / 2);
            var top = 10;
            window.open(link, 'popup', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
            return false;
        }
        function edit_textbox() {
            $('.edit_textbox').change(function () {
                var tx = $(this);
                var _workid = $(this).attr("data-workid");//tx.context.attributes["data-workid"].value;
                var _kpiid = $(this).attr("data-kpiid");//tx.context.attributes["data-kpiid"].value;
                var _itemid = $(this).attr("data-itemid");//tx.context.attributes["data-itemid"].value;
                var _valueold = $(this).attr("data-valueold");
                var _value = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "api/updatedatakpi?WorkId=" + _workid + "&KPIId=" + _kpiid + "&ItemId=" + _itemid + "&Value=" + _value,
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        if (data.StatusCode == 200) {
                            toastr.success(data.Content);
                            $('#' + _workid + "_" + _kpiid + "_" + _itemid).attr("data-valueold", _value);;
                            $('#lb_' + _workid + "_" + _kpiid + "_" + _itemid).text(_value);
                        }
                        else {
                            toastr.error(data.Content);
                            $('#' + _workid + "_" + _kpiid + "_" + _itemid).val(_valueold);
                        }
                    }
                });
            });
        }
        function export_excel() {
            $('#btnExport1').text('Đang xuất file ...');
            $('#a_file').hide();
            $('#btnExport1').disabled = 'true';
            setTimeout(
                function () {
                    $('#a_file').attr("href", "/Upload/export/Ket qua chi tiet_07_2022_4343f934.xlsx");
                    $('#a_file').show();
                }, 2000);
        }
    </script>
</asp:Content>
