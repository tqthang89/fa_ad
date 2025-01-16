<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SaleMT.aspx.cs" Inherits="ECS_Web.Report.SaleMT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Báo cáo viếng thăm cửa hàng (MT)</h3>
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
                                    <td style="padding-left: 100px;">
                                        <h3 class="card-title">SOS</h3>
                                    </td>
                                    <td style="padding-left: 20px;">
                                        <span class="badge bg-success">90%</span>
                                    </td>
                                    <td style="padding-left: 100px;">
                                        <h3 class="card-title">Offlocation</h3>
                                    </td>
                                    <td style="padding-left: 20px;">
                                        <span class="badge bg-success">90%</span>
                                    </td>
                                </tr>
                            </table>

                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <style>
                                table.table td {
                                    text-align: center;
                                }
                            </style>
                            <table class="table table-bordered table-hover">
                                <thead style="text-align: center; vertical-align: central;">
                                    <tr>
                                        <th rowspan="2" style="width: 10px">#</th>
                                        <th rowspan="2">Nhân viên</th>
                                        <th colspan="3">Doanh số</th>
                                        <th rowspan="2">OOS</th>
                                        <th rowspan="2">Stock</th>
                                        <th rowspan="2">SOS</th>
                                        <th rowspan="2">Offlocation</th>
                                    </tr>
                                    <tr>
                                        <th style="width: 400px;">Tỉ lệ thực hiện</th>
                                        <th>Số ngày LV còn lại</th>
                                        <th>Số tiền cần bán mỗi ngày</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1.</td>
                                        <td>Nhân viên 1</td>
                                        <td>
                                            <div class="progress-group" style="text-align: left;">
                                                55%
                                               
                                                <span class="float-right"><b>100tr</b>/200tr</span>
                                                <div class="progress progress-sm">
                                                    <div class="progress-bar bg-primary" style="width: 50%"></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>10</td>
                                        <td>10 triệu</td>
                                        <td>
                                            <span class="badge bg-primary">5%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary">85%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success">90%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success">90%</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2.</td>
                                        <td>Nhân viên 2</td>
                                        <td>
                                            <div class="progress-group" style="text-align: left;">
                                                70%
                                               
                                                <span class="float-right"><b>140tr</b>/200tr</span>
                                                <div class="progress progress-sm">
                                                    <div class="progress-bar bg-warning" style="width: 70%"></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>10</td>
                                        <td>10 triệu</td>
                                        <td>
                                            <span class="badge bg-primary">5%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary">85%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success">90%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success">90%</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>3.</td>
                                        <td>Nhân viên 3</td>
                                        <td>
                                            <div class="progress-group" style="text-align: left;">
                                                30%
                                               
                                                <span class="float-right"><b>60tr</b>/200tr</span>
                                                <div class="progress progress-sm">
                                                    <div class="progress-bar bg-danger" style="width: 30%"></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>10</td>
                                        <td>10 triệu</td>
                                        <td>
                                            <span class="badge bg-primary">5%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary">85%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success">90%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success">90%</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>4.</td>
                                        <td>Nhân viên 4</td>
                                        <td>
                                            <div class="progress-group" style="text-align: left;">
                                                90%
                                               
                                                <span class="float-right"><b>180tr</b>/200tr</span>
                                                <div class="progress progress-sm">
                                                    <div class="progress-bar bg-success" style="width: 90%"></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>10</td>
                                        <td>10 triệu</td>
                                        <td>
                                            <span class="badge bg-primary">5%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary">85%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success">90%</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success">90%</span>
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
                                                <asp:TemplateField HeaderText="Chuỗi S.Thị">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lbCustomer" Text='BigC'></asp:Label>
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
                                                        <asp:Label runat="server" ID="lbQC" Text='0/3 ( Chưa QC)'></asp:Label>
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
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link active" CommandName="ATT" ID="lbATT" OnClick="lbKPI_Click">Chấm công <br />(Daily) </asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="POG" ID="lbPOG" OnClick="lbKPI_Click">POG <br />(Daily) </asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SO" ID="lbSO" OnClick="lbKPI_Click">Bán hàng <br />(Daily)</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SURVEY" ID="lbSURVEY" OnClick="lbKPI_Click">OSA (80%) <br />(Daily)</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="IVT" ID="lbIVT" OnClick="lbKPI_Click">Inventory<br />(Weekly)</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="COM" ID="lbCOM" OnClick="lbKPI_Click">Competitor<br />(Weekly)</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="PRO" ID="lbPRO" OnClick="lbKPI_Click">Promotion<br />(Weekly)</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SOS" ID="lbSOS" OnClick="lbKPI_Click">SOS (45%) <br />(Monthly)</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="OOL" ID="lbOOL" OnClick="lbKPI_Click">Offlocation (90%) <br />(Monthly)</asp:LinkButton>
                                                                                </li>
                                                                                <li class="nav-item">
                                                                                    <asp:LinkButton runat="server" class="nav-link" CommandName="SURVEYALL" ID="lbSURVEYALL" OnClick="lbKPI_Click">Khảo sát khác <br />(Daily)</asp:LinkButton>
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
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="plIVT" Visible="false" Style="padding: 10px;">
                                                                            <div class="row">
                                                                                <div class="col-sm-6" style="height: 550px; overflow-y: scroll">
                                                                                    <table class="table table-bordered" style="width: 100%;">
                                                                                        <tbody style="font-style: italic;">
                                                                                            <tr>
                                                                                                <th><span class="badge bg-warning">T11</span></th>
                                                                                                <th>Tổng tiền kho</th>
                                                                                                <td>50 tỉ</td>
                                                                                                <th>WOS</th>
                                                                                                <td style="color: blue;">2.5</td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                    <table class="table">
                                                                                        <tr style="text-align: left; vertical-align: top">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th class="text-center">STT</th>
                                                                                                    <th class="text-center">Sản phẩm</th>
                                                                                                    <th class="text-center">Số SP lẻ</th>
                                                                                                    <th class="text-center">Số thùng</th>
                                                                                                    <th class="text-center">Tổng số SP</th>
                                                                                                    <th class="text-center">SO TB bán 1 tuần</th>
                                                                                                    <th class="text-center">WOS</th>
                                                                                                    <th class="text-center">SL cần mua</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td colspan="8" style="font-size: 18px; color: chocolate; text-align: left;">Nhãn hàng A</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">1</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 1 
                                                                                                        <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">33</td>
                                                                                                    <td style="text-align: center;">15</td>
                                                                                                    <td style="text-align: center;">2.2</td>
                                                                                                    <td style="text-align: center;">0</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 2 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">33</td>
                                                                                                    <td style="text-align: center;">20</td>
                                                                                                    <td style="text-align: center;">1.7</td>
                                                                                                    <td style="text-align: center;">7</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 3 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">2</td>
                                                                                                    <td style="text-align: center;">23</td>
                                                                                                    <td style="text-align: center;">20</td>
                                                                                                    <td style="text-align: center;">1.1</td>
                                                                                                    <td style="text-align: center;">17</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td colspan="8" style="font-size: 18px; color: chocolate; text-align: left;">Nhãn hàng B ( OSA: 50%)</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">4</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 4 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">0</td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">10</td>
                                                                                                    <td style="text-align: center;">0.3</td>
                                                                                                    <td style="text-align: center;">17</td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">5</td>
                                                                                                    <td style="text-align: center;">Sản phẩm 5 <i class="fas fa-eye" data-toggle="modal" data-target="#modal-default"></i></td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">3</td>
                                                                                                    <td style="text-align: center;">33</td>
                                                                                                    <td style="text-align: center;">10</td>
                                                                                                    <td style="text-align: center;">3.3</td>
                                                                                                    <td style="text-align: center;">0</td>
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
                                                                                <div class="col-sm-6">
                                                                                    <div class="card card-cyan">
                                                                                        <div class="card-header">
                                                                                            <h3 class="card-title">Trưng bày Line 1</h3>
                                                                                        </div>
                                                                                        <div class="card-body">
                                                                                            <table>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <img src="../Images/store.jpg" width="235" height="300"></td>
                                                                                                    <td>
                                                                                                        <img src="../Images/store.jpg" width="235" height="300"></td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-sm-6">
                                                                                    <div class="card card-primary">
                                                                                        <div class="card-header">
                                                                                            <h3 class="card-title">Hình mẫu</h3>
                                                                                        </div>
                                                                                        <div class="card-body">
                                                                                            <table>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <img src="../Images/pog.jpg" height="300"></td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-sm-6">
                                                                                    <div class="card card-cyan">
                                                                                        <div class="card-header">
                                                                                            <h3 class="card-title">Trưng bày Offlocation 1</h3>
                                                                                        </div>
                                                                                        <div class="card-body">
                                                                                            <table>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <img src="../Images/store.jpg" width="235" height="300"></td>
                                                                                                    <td>
                                                                                                        <img src="../Images/store.jpg" width="235" height="300"></td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-sm-6">
                                                                                    <div class="card card-primary">
                                                                                        <div class="card-header">
                                                                                            <h3 class="card-title">Hình mẫu</h3>
                                                                                        </div>
                                                                                        <div class="card-body">
                                                                                            <table>
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <img src="../Images/pog.jpg" height="300"></td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </div>
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
