<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SellOut.aspx.cs" Inherits="ECS_Web.Report.SellOut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Báo cáo bán hàng</h3>
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
                        <div class="col-md-3" data-select2-id="30">
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
                        <div class="col-md-3" data-select2-id="30">
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
                        <div class="col-md-2">
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
                                <label>(GT) Nhà phân phối</label>
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
                                <label>Nhân viên:</label>
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
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">

                    <div class="card">
                        <div class="card-header">
                            <table>
                                <tr>
                                    <td>
                                        <h3 class="card-title">Timegone</h3>
                                    </td>
                                    <td style="padding-left: 20px;">
                                        <div class="progress progress-xs progress-striped active" style="width: 100px;">
                                            <div class="progress-bar bg-primary" style="width: 50%"></div>
                                        </div>
                                    </td>
                                    <td style="padding-left: 20px;">
                                        <span class="badge bg-blue">50%</span>
                                    </td>

                                    <td style="padding-left: 100px;">
                                        <h3 class="card-title">Doanh số</h3>
                                    </td>
                                    <td style="padding-left: 20px;">
                                        <div class="progress progress-xs progress-striped active" style="width: 100px;">
                                            <div class="progress-bar bg-warning" style="width: 60%"></div>
                                        </div>
                                    </td>
                                    <td style="padding-left: 20px;">
                                        <span class="badge bg-warning">60%</span>
                                    </td>

                                    <td style="padding-left: 100px;">
                                        <h3 class="card-title">OOS</h3>
                                    </td>
                                    <td style="padding-left: 20px;">
                                        <span class="badge bg-warning">7%</span>
                                    </td>

                                    <td style="padding-left: 100px;">
                                        <h3 class="card-title">Stock</h3>
                                    </td>
                                    <td style="padding-left: 20px;">
                                        <span class="badge bg-warning">77%</span>
                                    </td>
                                </tr>
                            </table>

                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <table class="table table-bordered table-hover">
                                <thead style="text-align: center; vertical-align: central;">
                                    <tr>
                                        <th rowspan="2" style="width: 10px">#</th>
                                        <th rowspan="2">Nhân viên</th>
                                        <th colspan="6">Doanh số</th>
                                        <th rowspan="2">OOS</th>
                                        <th rowspan="2">Stock</th>
                                    </tr>
                                    <tr>
                                        <th>Chỉ tiêu</th>
                                        <th>Thực đạt</th>
                                        <th>Tỉ lệ đạt</th>
                                        <th>%</th>
                                        <th>Số ngày LV còn lại</th>
                                        <th>Số tiền cần bán mỗi ngày</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1.</td>
                                        <td>Nhân viên 1</td>
                                        <td>200 triệu</td>
                                        <td>100 triệu</td>

                                        <td>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar bg-primary" style="width: 55%"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary">55%</span>
                                        </td>
                                        <td>10</td>
                                        <td>10 triệu</td>
                                        <td>
                                            <span class="badge bg-primary">5%</span>
                                        </td>
                                         <td>
                                            <span class="badge bg-primary">85%</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2.</td>
                                        <td>Nhân viên 2</td>
                                        <td>200 triệu</td>
                                        <td>100 triệu</td>

                                        <td>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar bg-warning" style="width: 70%"></div>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-warning">70%</span></td>
                                        <td>10</td>
                                        <td>10 triệu</td>
                                        <td>
                                            <span class="badge bg-primary">5%</span>
                                        </td>
                                         <td>
                                            <span class="badge bg-primary">85%</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>3.</td>
                                        <td>Nhân viên 3</td>
                                        <td>200 triệu</td>
                                        <td>100 triệu</td>

                                        <td>
                                            <div class="progress progress-xs">
                                                <div class="progress-bar bg-danger" style="width: 30%"></div>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-danger">30%</span></td>
                                        <td>10</td>
                                        <td>10 triệu</td>
                                        <td>
                                            <span class="badge bg-primary">5%</span>
                                        </td>
                                         <td>
                                            <span class="badge bg-primary">85%</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>4.</td>
                                        <td>Nhân viên 4</td>
                                        <td>200 triệu</td>
                                        <td>100 triệu</td>

                                        <td>
                                            <div class="progress progress-xs progress-striped active">
                                                <div class="progress-bar bg-success" style="width: 90%"></div>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-success">90%</span></td>
                                        <td>10</td>
                                        <td>10 triệu</td>
                                        <td>
                                            <span class="badge bg-primary">5%</span>
                                        </td>
                                         <td>
                                            <span class="badge bg-primary">85%</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.card-body -->
                        <div class="card-footer clearfix" style="display: none;">
                            <ul class="pagination pagination-sm m-0 float-right">
                                <li class="page-item"><a class="page-link" href="#">«</a></li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">»</a></li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
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
                                                <asp:BoundField HeaderText="Nhân viên" DataField="EmployeeName" />
                                                <asp:BoundField HeaderText="Quản lý" DataField="ManagerName" />
                                                <asp:BoundField HeaderText="Ngày viếng thăm" DataField="SellDate" />
                                                <asp:TemplateField HeaderText="Loại viếng thăm">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbVisitType" CssClass='<%# Eval("VisitType").ToString().Contains("Mở mới")?"badge bg-warning":"" %>' Text='<%# Eval("VisitType") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="KQ Viếng thăm">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbVisitResult" CssClass='<%# Eval("VisitResult").ToString().Contains("KTC")?"badge bg-danger":"" %>' Text='<%# Eval("VisitResult") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemStyle Width="0px" />
                                                    <ItemTemplate>
                                                        <tr style="height: 40%">
                                                            <td colspan="100%" style="padding: 0px !important;">
                                                                <asp:Panel runat="server" ID="pnGrid" Visible="false" Style="padding: 10px;">
                                                                    <div class="card card-primary card-outline card-tabs">
                                                                        <div class="card-header p-0 pt-1 border-bottom-0">
                                                                            <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                                                                                <li class="nav-item" runat="server" id="liAtt">
                                                                                    <asp:LinkButton runat="server" class="nav-link active" CommandName="ATT" ID="lbAtt" OnClick="lbKPI_Click">Chấm công</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="liSO">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SO" ID="lbSO" OnClick="lbKPI_Click">Bán hàng</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item" runat="server" id="liSURVEY">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SURVEY" ID="lbSURVEY" OnClick="lbKPI_Click">Khảo sát ( CH mới)</asp:LinkButton>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                        <asp:Panel runat="server" ID="plAtt" Style="padding: 10px;">
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
                                                                        <asp:Panel runat="server" ID="pnSO" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered" style="width: auto;">
                                                                                        <tbody style="font-style: italic;">
                                                                                            <tr>
                                                                                                <th>Tổng đơn hàng</th>
                                                                                                <td>10.000.000đ</td>
                                                                                                <th>Giảm giá</th>
                                                                                                <td>1.000.000đ</td>
                                                                                            </tr>

                                                                                            <tr>
                                                                                                <th colspan="1">Giá trị đơn hàng</th>
                                                                                                <td colspan="1">9.000.000đ</td>
                                                                                                <td colspan="2"></td>
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
                                                                                                            <td colspan="5" style="font-size: 18px; color: chocolate;">Nhãn hàng 1</td>
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
                                                                                                    <td colspan="5" style="font-size: 18px; color: chocolate;">Thông tin cửa hàng</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Tên chủ cửa hàng</td>
                                                                                                    <td style="text-align: center;">CH Nguyen Thi A</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Số điện thoại</td>
                                                                                                    <td style="text-align: center;">0900000000</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Quận/Huyện</td>
                                                                                                    <td style="text-align: center;">Tân Phú</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">4</td>
                                                                                                    <td style="text-align: center;">Phường/Xã</td>
                                                                                                    <td style="text-align: center;">Phường Tân Phú</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">5</td>
                                                                                                    <td style="text-align: center;">Đường</td>
                                                                                                    <td style="text-align: center;">Đường Tân Phú</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">5</td>
                                                                                                    <td style="text-align: center;">Số nhà</td>
                                                                                                    <td style="text-align: center;">50/11</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">6</td>
                                                                                                    <td style="text-align: center;">Loại CH</td>
                                                                                                    <td style="text-align: center;">Tạp Hóa</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">7</td>
                                                                                                    <td style="text-align: center;">Vị trí</td>
                                                                                                    <td style="text-align: center;">Trong chợ</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td colspan="5" style="font-size: 18px; color: chocolate;">Trưng bày</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">8</td>
                                                                                                    <td style="text-align: center;">Diên tích trưng bày</td>
                                                                                                    <td style="text-align: center;">40-60m2</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">9</td>
                                                                                                    <td style="text-align: center;">Mặt hàng trưng bày</td>
                                                                                                    <td style="text-align: center;">Sữa; Nước Uống; Bánh Kẹo</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">10</td>
                                                                                                    <td style="text-align: center;">Đăng ký chương trình trưng bày</td>
                                                                                                    <td style="text-align: center;">Có</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td colspan="5" style="font-size: 18px; color: chocolate;">Doanh thu</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">11</td>
                                                                                                    <td style="text-align: center;">Doanh thu</td>
                                                                                                    <td style="text-align: center;">Từ 30-50triệu / 1 tháng</td>
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
