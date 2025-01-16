<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="AuditMer_GT.aspx.cs" Inherits="ECS_Web.Report.AuditMer_GT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Báo cáo viếng thăm cửa hàng (Audit - Mer)</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Chu kỳ:</label>
                                <asp:DropDownList runat="server" ID="ddlCycle" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">Chu kỳ 1/2022</asp:ListItem>
                                    <asp:ListItem Value="2">Chu kỳ 2/2022</asp:ListItem>
                                    <asp:ListItem Value="3">Chu kỳ 3/2022</asp:ListItem>
                                    <asp:ListItem Value="4">Chu kỳ 4/2022</asp:ListItem>
                                    <asp:ListItem Value="4">Chu kỳ 5/2022</asp:ListItem>
                                    <asp:ListItem Value="5">Chu kỳ 6/2022</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
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
                        <div class="col-md-2" data-select2-id="30">
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
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Khu vực:</label>
                                <asp:DropDownList runat="server" ID="ddlArea" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Miền Bắc</asp:ListItem>
                                    <asp:ListItem Value="3">Miền Trung</asp:ListItem>
                                    <asp:ListItem Value="4">Miền Đông</asp:ListItem>
                                    <asp:ListItem Value="5">HCM</asp:ListItem>
                                    <asp:ListItem Value="6">Mê Kông</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>ASM:</label>
                                <asp:DropDownList runat="server" ID="ddlASM" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">ASM 1</asp:ListItem>
                                    <asp:ListItem Value="3">ASM 2</asp:ListItem>
                                    <asp:ListItem Value="4">ASM 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Supervisor:</label>
                                <asp:DropDownList runat="server" ID="ddlSUP" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Supervisor 1</asp:ListItem>
                                    <asp:ListItem Value="3">Supervisor 2</asp:ListItem>
                                    <asp:ListItem Value="4">Supervisor 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3" data-select2-id="30" style="display:none;">
                            <div class="form-group" data-select2-id="29">
                                <label>(MT) Chuỗi siêu thị</label>
                                <asp:DropDownList runat="server" ID="ddl1" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">Aeon</asp:ListItem>
                                    <asp:ListItem Value="2">BHX</asp:ListItem>
                                    <asp:ListItem Value="3">BigC</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-2" style="display:none;">
                            <div class="form-group" data-select2-id="29">
                                <label>(MT) Loại hình</label>
                                <asp:DropDownList runat="server" ID="DropDownList1" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">Supermarket</asp:ListItem>
                                    <asp:ListItem Value="2">Hypermarket</asp:ListItem>
                                    <asp:ListItem Value="3">Minimart</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group" data-select2-id="29">
                                <label>Nhà phân phối</label>
                                <asp:DropDownList runat="server" ID="DropDownList2" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">NPP 1</asp:ListItem>
                                    <asp:ListItem Value="2">NPP 2</asp:ListItem>
                                    <asp:ListItem Value="3">NPP 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Nhân viên Auditer:</label>
                                <asp:DropDownList runat="server" ID="DropDownList3" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Nhân viên 1</asp:ListItem>
                                    <asp:ListItem Value="3">Nhân viên 2</asp:ListItem>
                                    <asp:ListItem Value="4">Nhân viên 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Kết quả viếng thăm:</label>
                                <asp:DropDownList runat="server" ID="DropDownList4" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Thành công</asp:ListItem>
                                    <asp:ListItem Value="3">KTC - CH đóng cửa do Covid</asp:ListItem>
                                    <asp:ListItem Value="4">KTC - CH đóng cửa do nhà nước thông báo</asp:ListItem>
                                    <asp:ListItem Value="5">KTC - CH Chuyển loại hình kinh doanh</asp:ListItem>
                                    <asp:ListItem Value="6">KTC - Thiên tai</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <%--<div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Kết quả phản hồi cửa Sales:</label>
                                <asp:DropDownList runat="server" ID="DropDownList5" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Chưa phản hồi</asp:ListItem>
                                    <asp:ListItem Value="3">Đã phản hồi - Đồng ý</asp:ListItem>
                                    <asp:ListItem Value="4">Đã phản hồi - Ko đồng ý</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>--%>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Gói trưng bày:</label>
                                <asp:DropDownList runat="server" ID="DropDownList6" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">GOLDEN</asp:ListItem>
                                    <asp:ListItem Value="3">DIAMOND</asp:ListItem>
                                    <asp:ListItem Value="4">SILVER</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Kết quả chấm điểm:</label>
                                <asp:DropDownList runat="server" ID="DropDownList7" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Đạt trưng bày</asp:ListItem>
                                    <asp:ListItem Value="3">Rớt trưng bày</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.card-body -->
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-3" data-select2-id="30">
                            <asp:Button runat="server" class="btn btn-primary" Text="Tìm kiếm" ID="btnFilter" OnClick="btnFilter_Click" />
                            <asp:Button runat="server" class="btn btn-primary" Visible="false" Text="Xuất báo cáo" ID="btnExport1111" OnClick="btnExport1111_Click" />
                            <asp:Label runat="server" ID="lbMessage" Text=""></asp:Label>
                        </div>
                        <div class="col-md-3" data-select2-id="30">
                        </div>
                        <div class="col-md-3" data-select2-id="30" style="display: none;">
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="exampleInputFile">
                                        <asp:FileUpload runat="server" ID="flImport" class="custom-file-input" />
                                        <label class="custom-file-label" for="exampleInputFile">Choose file</label>
                                    </div>
                                    <div class="input-group-append">
                                        <asp:Button runat="server" class="btn btn-danger" Text="Nhập liệu" ID="Button1" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <asp:HiddenField ID="hdlChooseDisplay" runat="server" />
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content" id="sec_detail" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Chi tiết cửa hàng</h3>
                        </div>
                        <div class="card-body">
                            <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <asp:GridView runat="server" ID="gvSellOut" AutoGenerateColumns="false" class="table table-bordered table-hover dataTable dtr-inline">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="img" ImageUrl="~/images/plus.png" runat="server" OnClick="img_Click" CommandName="Show" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="STT" DataField="STT" />
                                                <asp:TemplateField HeaderText="Tên cửa hàng">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbShopName" Text='<%# Eval("ShopName") %>'></asp:Label>
                                                        - 0900000000
                                                        <asp:ImageButton ID="imgNew" Width="40px" Height="30px" Visible="false" ImageUrl="~/images/new_red.png" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Địa chỉ" DataField="ShopAddress" />
                                                <asp:BoundField HeaderText="Auditer" DataField="EmployeeName" />
                                                <asp:BoundField HeaderText="Quản lý" DataField="ManagerName" />
                                                <asp:TemplateField HeaderText="Chuỗi S.Thị" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbCustomer" Text='BigC'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 <asp:TemplateField HeaderText="Gói TB">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbCustomer111" Text='GOLDEN'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Ngày viếng thăm" DataField="SellDate" />
                                                <asp:BoundField HeaderText="Loại viếng thăm" DataField="VisitType" Visible="false" />
                                                <asp:TemplateField HeaderText="KQ Viếng thăm">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbVisitResult" CssClass='<%# Eval("VisitResult").ToString().Contains("KTC")?"badge bg-danger":"" %>' Text='<%# Eval("VisitResult") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="KQ QC">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbQC" Text='Đang QC'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Sale phản hồi">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbCustomer24343" Text='Đã đồng ý'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemStyle Width="0px" />
                                                    <ItemTemplate>
                                                        <tr style="height: 40%">
                                                            <td colspan="100%" style="padding: 0px !important;">
                                                                <asp:Panel runat="server" ID="pnGrid" Visible="false" Style="padding: 10px;">
                                                                    <audio controls="controls" style="width: 400px" >
                                                                        <source src="../Images/audio.mp3" type="audio/mpeg">
                                                                    </audio>
                                                                    <audio controls="controls" style="width: 400px">
                                                                        <source src="../Images/audio.mp3" type="audio/mpeg">
                                                                    </audio>
                                                                    <div class="card card-primary card-outline card-tabs">
                                                                        <div class="card-header p-0 pt-1 border-bottom-0">
                                                                            <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link active" CommandName="ATT" ID="lbATT" OnClick="lbKPI_Click">Chấm công </asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="POG" ID="lbPOG" OnClick="lbKPI_Click">Hot Zone </asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SURVEY" ID="lbSURVEY" OnClick="lbKPI_Click">Gói TB Golden</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" style="display:none;">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SOS" ID="lbSOS" OnClick="lbKPI_Click">SOS (45%)</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" style="display:none;">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="OOL" ID="lbOOL" OnClick="lbKPI_Click">Offlocation (90%)</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="IVT" ID="lbIVT" OnClick="lbKPI_Click">TB kệ phụ</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" style="display:none;">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="COM" ID="lbCOM" OnClick="lbKPI_Click">Competitor</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" style="display:none;">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="PRO" ID="lbPRO" OnClick="lbKPI_Click">Promotion</asp:LinkButton>
                                                                                </li>
                                                                                 <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="POSM" ID="lbPOSM" OnClick="lbKPI_Click">POSM</asp:LinkButton>
                                                                                </li>

                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SURVEYALL" ID="lbSURVEYALL" OnClick="lbKPI_Click">Khảo sát khác</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="PXN" ID="lbPXN" OnClick="lbKPI_Click">Phiếu xác nhận</asp:LinkButton>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                        <asp:Panel runat="server" ID="plATT" Style="padding: 10px;">
                                                                            <table style="width: 100%;">
                                                                                <tr style="text-align: center;">
                                                                                    <td>Check In</td>
                                                                                    <td>Check Out</td>
                                                                                    <td>Thời gian tại cửa hàng</td>
                                                                                    <td>Overview</td>
                                                                                </tr>
                                                                                <tr style="text-align: center;">
                                                                                    <td>2022-04-01 09:00:00
                                                                                        <br />
                                                                                        Tọa độ: 13.1984159 108.6861718
                                                                                        <br />
                                                                                        K/ Cách: 10m
                                                                                        <br />
                                                                                        <img src="../Images/store.jpg" width="235" height="300" />
                                                                                    </td>
                                                                                    <td>2022-04-01 09:20:00
                                                                                        <br />
                                                                                        Tọa độ: 13.1984159 108.6861718
                                                                                        <br />
                                                                                        K/ Cách: 15m
                                                                                        <br />
                                                                                        <img src="../Images/store.jpg" width="235" height="300" />
                                                                                    </td>
                                                                                    <td style="vertical-align: bottom;">00:20:00
                                                                                        <br />
                                                                                        <img style="border: 1px solid red;" src="https://maps.googleapis.com/maps/api/staticmap?center=13.1984,108.686&zoom=18&size=600x300&maptype=roadmap&markers=color:red%7Clabel:Shop%7C13.1984,108.686&key=AIzaSyAa8HeLH2lQMbPeOiMlM9D1VxZ7pbGQq8o" />
                                                                                    </td>
                                                                                    <td>2022-04-01 08:55:00
                                                                                        <br />
                                                                                        Tọa độ: 13.1984159 108.6861718
                                                                                        <br />
                                                                                        K/ Cách: 15m
                                                                                        <br />
                                                                                        <img src="../Images/store.jpg" width="235" height="300" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plSO" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered" style="width: 100%;">
                                                                                        <tbody style="font-style: italic;">
                                                                                            <tr>
                                                                                                <th>Tổng đơn hàng</th>
                                                                                                <td>10.000.000đ</td>
                                                                                                <th>Giảm giá</th>
                                                                                                <td>1.000.000đ</td>
                                                                                                <th colspan="1">Giá trị đơn hàng</th>
                                                                                                <td colspan="1">9.000.000đ</td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Sản phẩm</th>
                                                                                                    <th class="text-center">Số lượng</th>
                                                                                                    <th class="text-center">Giá</th>
                                                                                                    <th class="text-center">Thành Tiền</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <asp:Repeater runat="server" ID="rptDetails">
                                                                                                    <ItemTemplate>
                                                                                                        <tr runat="server" id="tr11" visible='<%# (Eval("STT").ToString() == "1" || Eval("STT").ToString() == "5" ? true:false) %>'>
                                                                                                            <td colspan="5" style="font-size: 18px; color: chocolate; text-align: left;">Nhãn hàng 1</td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td style="text-align: center;"><%# Eval("STT") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("ProductName") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("Quantỉy") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("Price") %></td>
                                                                                                            <td style="text-align: center;"><%# Eval("Amount") %></td>
                                                                                                        </tr>
                                                                                                    </ItemTemplate>
                                                                                                </asp:Repeater>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plSURVEY" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered" style="width: 100%;">
                                                                                        <tbody style="font-style: italic;">
                                                                                            <tr>
                                                                                                <th><span class="badge bg-warning">T11</span></th>
                                                                                                <th>Tổng số SP</th>
                                                                                                <td>5</td>
                                                                                                <th>Đạt</th>
                                                                                                <td style="color: blue;">60% (3/5)</td>
                                                                                                <th>Rớt</th>
                                                                                                <td style="color: red;">40% ( 2/5)</td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th><span class="badge bg-primary">T12</span></th>
                                                                                                <th>Tổng số SP</th>
                                                                                                <td>5</td>
                                                                                                <th>Đạt</th>
                                                                                                <td style="color: blue;">60% ( 3/5)</td>
                                                                                                <th>Rớt</th>
                                                                                                <td style="color: red;">20% ( 1/5)</td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Sản phẩm</th>
                                                                                                    <th class="text-center">Tiêu chí</th>
                                                                                                    <th class="text-center">Thực tế</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td colspan="5" style="font-size: 18px; color: chocolate; text-align: left;">Khảo sát</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Sản phẩm có trưng bày thành khối không? 
                                                                                                    </td>
                                                                                                    <td style="text-align: center;"></td>
                                                                                                    <td style="text-align: center;">Có</td>
                                                                                                    <td style="text-align: center;">Đạt</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Có bị xen kẽ sản phẩm đối thủ A hay không? 
                                                                                                    </td>
                                                                                                    <td style="text-align: center;"></td>
                                                                                                    <td style="text-align: center;">Có</td>
                                                                                                    <td style="text-align: center;"><span class="badge bg-warning">Rớt</span></td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td colspan="5" style="font-size: 18px; color: chocolate; text-align: left;">Nhãn hàng A ( OSA: 67%)</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 1 
                                                                                                        <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i>
                                                                                                        <input type="image" src="../images/new_red.png" style="height: 30px; width: 40px;">
                                                                                                    </td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Đạt</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 2 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Đạt</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 3 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;"><span class="badge bg-warning">Rớt</span></td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td colspan="5" style="font-size: 18px; color: chocolate; text-align: left;">Nhãn hàng B ( OSA: 50%)</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">4</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 4 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">0</td>
                                                                                                    <td style="text-align: center;"><span class="badge bg-danger">Hết hàng</span></td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">5</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 5 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Đạt</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <section class="content">

                                                                                <!-- Default box -->
                                                                                <div class="card">
                                                                                    <div class="card-header">
                                                                                        <h3 class="card-title">Trao đổi giữa team Audit vs Sales thị trường</h3>

                                                                                        <div class="card-tools">
                                                                                            <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                                                                                                <i class="fas fa-minus"></i>
                                                                                            </button>
                                                                                            <button type="button" class="btn btn-tool" data-card-widget="remove" data-toggle="tooltip" title="Remove">
                                                                                                <i class="fas fa-times"></i>
                                                                                            </button>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="card-body">

                                                                                        <div class="row">
                                                                                            <div class="col-12">
                                                                                                <div class="post">
                                                                                                    <div class="user-block">
                                                                                                        <img class="img-circle img-bordered-sm" src="../AdminLTE/dist/img/user1-128x128.jpg" alt="user image">
                                                                                                        <span class="username">
                                                                                                            <a href="#">Sale Trần Văn A</a>
                                                                                                        </span>
                                                                                                        <span class="description">Không đồng ý - 7:45 PM 12/12/2022</span>
                                                                                                    </div>
                                                                                                    <!-- /.user-block -->
                                                                                                    <p>
                                                                                                        Auditer, QC cần xem lại số liệu hết hàng
                                                                                                   
                                                                                                    </p>
                                                                                                    <p>
                                                                                                        <a href="#" class="link-black text-sm"><i class="fas fa-link mr-1"></i>File bằng chứng</a>
                                                                                                    </p>
                                                                                                </div>

                                                                                                <div class="post clearfix">
                                                                                                    <div class="user-block">
                                                                                                        <img class="img-circle img-bordered-sm" src="../AdminLTE/dist/img/user7-128x128.jpg" alt="User Image">
                                                                                                        <span class="username">
                                                                                                            <a href="#">Amin Nguyễn Thị B</a>
                                                                                                        </span>
                                                                                                        <span class="description">Phản hồi - 7h PM 15/12/2022</span>
                                                                                                    </div>
                                                                                                    <!-- /.user-block -->
                                                                                                    <p>
                                                                                                        Auditer, QC đã làm đúng.
                                                                                                    </p>
                                                                                                    <p>
                                                                                                        <a href="#" class="link-black text-sm"><i class="fas fa-link mr-1"></i>File bằng chứng 2</a>
                                                                                                    </p>
                                                                                                </div>

                                                                                                <div class="post">
                                                                                                    <div class="user-block">
                                                                                                        <img class="img-circle img-bordered-sm" src="../AdminLTE/dist/img/user1-128x128.jpg" alt="user image">
                                                                                                        <span class="username">
                                                                                                            <a href="#">Sales Trần Văn A.</a>
                                                                                                        </span>
                                                                                                        <span class="description">Đồng ý - 10h PM 17/12/2022</span>
                                                                                                    </div>
                                                                                                    <!-- /.user-block -->
                                                                                                    <p>
                                                                                                        Đồng ý
                                                                                                    </p>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                    </div>
                                                                                    <!-- /.card-body -->
                                                                                </div>
                                                                                <!-- /.card -->

                                                                            </section>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plIVT" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered" style="width: 100%;">
                                                                                        <tbody style="font-style: italic;">
                                                                                            <tr>
                                                                                                <th>Chỉ tiêu</th>
                                                                                                <td>50</td>
                                                                                                <th>Thực tế</th>
                                                                                                <td>Đạt - 80 % ( 40/50) </td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Sản phẩm</th>
                                                                                                    <th class="text-center">Chỉ tiêu</th>
                                                                                                    <th class="text-center">Thực tế</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 1 </td>
                                                                                                    <td style="text-align: center;">30</td>
                                                                                                    <td style="text-align: center;">30</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 2</td>
                                                                                                    <td style="text-align: center;">20</td>
                                                                                                    <td style="text-align: center;">10</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plCOM" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Đối thủ</th>
                                                                                                    <th class="text-center">CTKM</th>
                                                                                                    <th class="text-center">Từ ngày</th>
                                                                                                    <th class="text-center">Đến ngày</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Đối thủ 1</td>
                                                                                                    <td style="text-align: center;">Mua 10 sản phẩm tặng khăn mặt</td>
                                                                                                    <td style="text-align: center;">01/12/2022</td>
                                                                                                    <td style="text-align: center;">05/12/2022</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Đối thủ 1 </td>
                                                                                                    <td style="text-align: center;">Mua 20 sản phẩm tặng cốc thủy tinh</td>
                                                                                                    <td style="text-align: center;">01/12/2022</td>
                                                                                                    <td style="text-align: center;">05/12/2022</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plPRO" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">CTKM</th>
                                                                                                    <th class="text-center">Sản phẩm</th>
                                                                                                    <th class="text-center">Nội dung</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">CTKM tháng 12/2022</td>
                                                                                                    <td style="text-align: center;">Sản phẩm A</td>
                                                                                                    <td style="text-align: center;">Mua 10 sản phẩm tặng khăn mặt</td>
                                                                                                    <td style="text-align: center;">Có</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">CTKM tháng 12/2022 </td>
                                                                                                    <td style="text-align: center;">Sản phẩm B</td>
                                                                                                    <td style="text-align: center;">Mua 20 sản phẩm tặng cốc thủy tinh</td>
                                                                                                    <td style="text-align: center;">Có</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plSURVEYALL" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Khảo sát</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Tình hình kinh doanh năm 2022 so với 2021 ntn ?</td>
                                                                                                    <td style="text-align: center;">Tố hơn</td>
                                                                                                </tr>
                                                                                                 <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Top 3 công ty thuốc BVTV bán tốt nhất?</td>
                                                                                                    <td style="text-align: center;">Syngenta,Bayer,Corteva</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Nhập chữ</td>
                                                                                                    <td style="text-align: center;">ABC</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Nhập số </td>
                                                                                                    <td style="text-align: center;">10</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Chọn kết quả </td>
                                                                                                    <td style="text-align: center;">Kết quả 1</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">4</td>
                                                                                                    <td style="text-align: center;">Chọn nhiều kết quả </td>
                                                                                                    <td style="text-align: center;">Kết quả 1;Kết quả 2</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">5</td>
                                                                                                    <td style="text-align: center;">Chụp hình </td>
                                                                                                    <td style="text-align: center;">Có</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plPOG" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Câu hỏi</th>
                                                                                                    <th class="text-center">Thực tế</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Kệ chính được trưng bày ở vị trí nào</td>
                                                                                                    <td style="text-align: center;">Ngang tầm mắt</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Kệ chính gần quầy tính tiền hay không? </td>
                                                                                                    <td style="text-align: center;">Có</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plSOS" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered" style="width: 100%;">
                                                                                        <tbody style="font-style: italic;">
                                                                                            <tr>
                                                                                                <th><span class="badge bg-warning">T11</span></th>
                                                                                                <th>Siêu thị</th>
                                                                                                <td>100m</td>
                                                                                                <th>Công ty</th>
                                                                                                <td>40% ( 40m)</td>
                                                                                                <th>Đối thủ 1</th>
                                                                                                <td>27% ( 27m)</td>
                                                                                                <th>Công ty khác</th>
                                                                                                <td>43% ( 43m)</td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th><span class="badge bg-primary">T12</span></th>
                                                                                                <th>Siêu thị</th>
                                                                                                <td>100m</td>
                                                                                                <th>Công ty</th>
                                                                                                <td style="color: blue;">45% ( 45m)</td>
                                                                                                <th>Đối thủ 1</th>
                                                                                                <td>25% ( 25m)</td>
                                                                                                <th>Công ty khác</th>
                                                                                                <td>35% ( 35m)</td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Ngành hàng</th>
                                                                                                    <th class="text-center">Công ty</th>
                                                                                                    <th class="text-center">Đối thủ 1</th>
                                                                                                    <th class="text-center">Cty khác</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td colspan="5" style="font-size: 18px; color: chocolate; text-align: left;">Ngành hàng A ( Cty: 53%; Đối thủ: 14%; Cty khác: 33%)</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Loại sản phẩm 1</td>
                                                                                                    <td style="text-align: center;">10m</td>
                                                                                                    <td style="text-align: center;">6m</td>
                                                                                                    <td style="text-align: center;">4m</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Loại sản phẩm 2 </td>
                                                                                                    <td style="text-align: center;">10m</td>
                                                                                                    <td style="text-align: center;">6m</td>
                                                                                                    <td style="text-align: center;">4m</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Loại sản phẩm 3 </td>
                                                                                                    <td style="text-align: center;">10m</td>
                                                                                                    <td style="text-align: center;">6m</td>
                                                                                                    <td style="text-align: center;">4m</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td colspan="5" style="font-size: 18px; color: chocolate; text-align: left;">Ngành hàng B ( Cty: 53%; Đối thủ: 14%; Cty khác: 33%)</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">4</td>
                                                                                                    <td style="text-align: center;">Loại sản phẩm 4 </td>
                                                                                                    <td style="text-align: center;">10m</td>
                                                                                                    <td style="text-align: center;">6m</td>
                                                                                                    <td style="text-align: center;">4m</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">5</td>
                                                                                                    <td style="text-align: center;">Loại sản phẩm 5 </td>
                                                                                                    <td style="text-align: center;">10m</td>
                                                                                                    <td style="text-align: center;">6m</td>
                                                                                                    <td style="text-align: center;">4m</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plOOL" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered" style="width: 100%;">
                                                                                        <tbody style="font-style: italic;">
                                                                                            <tr>
                                                                                                <th><span class="badge bg-warning">T11</span></th>
                                                                                                <th>Tổng Offlocation</th>
                                                                                                <td>5</td>
                                                                                                <th>Đạt</th>
                                                                                                <td>60% ( 3/5)</td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <th><span class="badge bg-primary">T12</span></th>
                                                                                                <th>Tổng Offlocation</th>
                                                                                                <td>5</td>
                                                                                                <th>Đạt</th>
                                                                                                <td>80% ( 4/5)</td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Offlocation</th>
                                                                                                    <th class="text-center">Chỉ tiêu</th>
                                                                                                    <th class="text-center">Thực tế</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Offlocation 1</td>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Đạt</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Offlocation 1 </td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Đạt</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Offlocation 3 </td>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">0</td>
                                                                                                    <td style="text-align: center;"><span class="badge bg-danger">Rớt</span></td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">4</td>
                                                                                                    <td style="text-align: center;">Offlocation 4</td>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Đạt</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">5</td>
                                                                                                    <td style="text-align: center;">Offlocation 5</td>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Đạt</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>

                                                                        <asp:Panel runat="server" ID="plPXN" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Khảo sát</th>
                                                                                                    <th class="text-center">Kết quả</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Chủ cửa hàng có đồng ý ký phiếu xác nhận không?</td>
                                                                                                    <td style="text-align: center;">Có</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhotoPXN" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plPOSM" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">POSM</th>
                                                                                                    <th class="text-center">Chỉ tiêu</th>
                                                                                                    <th class="text-center">Thực tế</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">POSM 1 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">4</td>
                                                                                                    <td style="text-align: center;"><span class="badge bg-danger">3</span></td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">POSM 2 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">POSM 3 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                     <td style="text-align: center;">4</td>
                                                                                                    <td style="text-align: center;">POSM 4 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="images">
                                                                                        <iframe src="ReportPhoto" frameborder='0' frameborder='0' scrolling='yes' width='750px' height='600px'></iframe>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>
                                                                        <!-- /.card -->
                                                                    </div>

                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-12 col-md-5">
                                        <div class="dataTables_info" id="example2_info" role="status" aria-live="polite">Showing 1 to 10 of 57 entries</div>
                                    </div>
                                    <div class="col-sm-12 col-md-7">
                                        <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
                                            <ul class="pagination">
                                                <li class="paginate_button page-item previous disabled" id="example2_previous"><a href="#" aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
                                                <li class="paginate_button page-item active"><a href="#" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
                                                <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>
                                                <li class="paginate_button page-item next" id="example2_next"><a href="#" aria-controls="example2" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </div>
    </section>
    <div class="modal fade" id="modal-default" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Ảnh mẫu sản phẩm</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <img src="../Images/product_temp.jpg" />
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <script>
        function showvalue() {
            document.getElementById('<%= hdlChooseDisplay.ClientID %>').value = $("#ddlmt").val();
        }
        var requestManager = Sys.WebForms.PageRequestManager.getInstance();
        requestManager.add_endRequest(function () {
            try {
                var s2 = $("#ddlmt").select2({
                    placeholder: "--All--",
                    tags: true
                });
                var vals = document.getElementById('<%= hdlChooseDisplay.ClientID %>').value.split(','); // ["1", "2", "3"];
                s2.val(vals).trigger("change");
            } catch (e) {

            }
        });
    </script>
</asp:Content>
