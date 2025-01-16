<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="WorkResultGuest.aspx.cs" Inherits="ECS_Web.Report.WorkResultGuest" %>

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
                                <label >Chu kỳ:</label>
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
                                <label>MDO:</label>
                                <asp:DropDownList runat="server" ID="ddlMDO" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
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
                         <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Kết quả QC Cửa hàng:</label>
                                <asp:DropDownList runat="server" ID="ddlQC" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="-1">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="4">Đang QC</asp:ListItem>
                                    <asp:ListItem Value="1">Pass</asp:ListItem>
                                    <asp:ListItem Value="2">Reject</asp:ListItem>
                                    <asp:ListItem Value="3">Review</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>ID cửa hàng:</label>
                                <asp:TextBox runat="server" ID="txtShopCode" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button runat="server" class="btn btn-primary" Text="Tìm kiếm" ID="btnFilter" OnClick="btnFilter_Click" />

                            <asp:Button runat="server" class="btn btn-primary"  Text="Xuất báo cáo" ID="btnExport" OnClick="btnExport_Click" UseSubmitBehavior="false" Style="float: right;" />
                            <asp:DropDownList runat="server" ID="ddlTypeReport" Style="width: 150px; height: 37px; float: right; margin-right: 20px;">
                                <asp:ListItem Text="Báo cáo tổng hợp" Value="6" />
                            </asp:DropDownList>
                        </div>
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
                                                                <asp:Label Text='<%# Eval("IsLockReport") %>' Visible="false" runat="server" ID="lbIsLockReport" />
                                                            </td>
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
                                                            </td>
                                                            <td><%# Eval("StoreCard") %></td>
                                                            <td><%# Eval("PaymentPercent") %></td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label11" CssClass='<%# Eval("IsLockReport").ToString().Contains("0")?"badge bg-danger":"" %>' Text='<%# Eval("IsLockReport").ToString().Contains("0")?"Chưa QC":"Đã QC" %>'></asp:Label>
                                                            </td>
                                                            
                                                          <%--  <td><%# Eval("QCStatusName") %></td>--%>
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
                                                                                <li class="nav-item" runat="server" id="li_surveyother">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SURVEYALL" ID="lbSURVEYALL" OnClick="lbKPI_Click">Khảo sát khác</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_createshop" visible="false">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="CTEATESHOP" ID="lbCREATESHOP" OnClick="lbKPI_Click">Tạo mới cửa hàng </asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="li_promotion">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="PRO" ID="lbPRO" OnClick="lbKPI_Click">Phiếu xác nhận</asp:LinkButton>
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
                                                                        <asp:Panel runat="server" ID="plATT">
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
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptHotzone">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("SurveyName") %></td>
                                                                                                            <td style="text-align: center;"><%--<%# Convert.ToString(Eval("AnswerName")) %>--%>
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_1_" + Eval("SurveyId")%>' ><%# Eval("AnswerName") %></span>
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
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">KPI</th>
                                                                                                    <th class="text-center">Chỉ tiêu</th>
                                                                                                    <th class="text-center">Thực tế</th>
                                                                                                    <th class="text-center">%</th>
                                                                                                    <th class="text-center">StoreCard</th>
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
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
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
                                                                                                    <th class="text-center">Tỉ Trọng</th>
                                                                                                    <th class="text-center">T/tế |  <asp:CheckBox runat="server" ID="cbAllOSA" Text="Tất cả" AutoPostBack="true" OnCheckedChanged="cbAllOSA_CheckedChanged" /></th>
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
                                                                                                            <td style="text-align: center;"><%# Eval("Coefficient") %>
                                                                                                            <td style="text-align: center;">
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_2_" + Eval("ProductId")%>' class='<%# Eval("OSAValue").ToString().Contains("KĐạt") || Eval("OSAValue").ToString()=="0"?"badge bg-danger":"" %>'><%# Eval("OSAValue") %></span>
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
                                                                                                    <th class="text-center" >T/Thái</th>
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
                                                                                                            <td> <span class='<%# Eval("Status").ToString().Contains("2")?"badge bg-danger":"" %>'><%# Eval("StatusName") %></span></td>
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
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptSURVEYALL">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("SurveyName") %></td>
                                                                                                            <td style="text-align: center;max-width:200px;"><%--<%# Convert.ToString(Eval("AnswerName")) %>--%>
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_5_" + Eval("SurveyId")%>' ><%# Eval("AnswerName") %></span>
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
                                                                        <asp:Panel runat="server" ID="plPRO" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Khảo sát</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptPRO">
                                                                                                    <ItemTemplate>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("RN") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("SurveyName") %></td>
                                                                                                            <td style="text-align: center;"><%--<%# Convert.ToString(Eval("AnswerName")) %>--%>
                                                                                                                <span id='<%# "lb_"+Eval("WorkId") +"_4_" + Eval("SurveyId")%>' ><%# Eval("AnswerName") %></span>
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

                                                                        <asp:Panel runat="server" ID="plCREATESHOP" Visible="false">
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
                                                                                                                    <td style="font-weight: bold;">Địa chỉ</td>
                                                                                                                    <td colspan="3"><%# Eval("addressline") %></td>
                                                                                                                </tr>
                                                                                                                <tr>
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
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td style="font-weight: bold;">Doanh thu ( triệu)</td>
                                                                                                                    <td><%# Eval("revenue") %></td>
                                                                                                                    <td style="font-weight: bold;">Tọa độ</td>
                                                                                                                    <td><%# Convert.ToString(Eval("latitude")) + " "+ Convert.ToString(Eval("longitude")) %></td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                        <td style="text-align: center;">
                                                                                                            <img src='<%# Eval("photo") %>' style="height: 300px;" />
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
                                                                    </asp:Panel>
                                                                    <br />
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
                                                        Showing
                                                        <asp:Label ID="lblFrom" runat="server" />
                                                        to
                                                        <asp:Label ID="lblTo" runat="server" />
                                                        of
                                                        <asp:Label ID="lblTotalRows" runat="server" />
                                                        entries
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 col-md-7" style="display:none;">
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
    </script>
</asp:Content>
