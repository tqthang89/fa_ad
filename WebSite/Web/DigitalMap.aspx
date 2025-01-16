<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DigitalMap.aspx.cs" Inherits="ECS_Web.DigitalMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <style>
        .highcharts-figure,
        .highcharts-data-table table {
            min-width: 310px;
            max-width: 800px;
            margin: 1em auto;
        }

        #container {
            height: 400px;
        }

        .highcharts-data-table table {
            font-family: Verdana, sans-serif;
            border-collapse: collapse;
            border: 1px solid #ebebeb;
            margin: 10px auto;
            text-align: center;
            width: 100%;
            max-width: 500px;
        }

        .highcharts-data-table caption {
            padding: 1em 0;
            font-size: 1.2em;
            color: #555;
        }

        .highcharts-data-table th {
            font-weight: 600;
            padding: 0.5em;
        }

        .highcharts-data-table td,
        .highcharts-data-table th,
        .highcharts-data-table caption {
            padding: 0.5em;
        }

        .highcharts-data-table thead tr,
        .highcharts-data-table tr:nth-child(even) {
            background: #f8f8f8;
        }

        .highcharts-data-table tr:hover {
            background: #f1f7ff;
        }
    </style>
    <style>
        #map {
            height: 100%;
        }

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        span {
            z-index: 10000 !important;
        }
    </style>
    <style>
        table.table td, table.table th {
            border: 1px solid #dee2e6;
            padding: 0.5rem !important;
            text-align: center;
        }
    </style>
    <script src="../Scripts/jquery-3.4.1.min.js"></script>
    <script>
        $(document).ready(function () {
            $("a.nav-link").first().trigger("click");
            window.setTimeout(function () {
            }, 500);
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info collapsed-card" style="z-index: 10000;">
                <div class="card-header">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 100px;">Bản đồ số</td>
                            <td style="text-align: left; width: 200px; font-weight: bold;">Tổng số: 996 CH </td>
                            <td style="text-align: left; width: 850px;">
                                <table>
                                    <tr>
                                        <td>
                                            <img src="Images/map_red.png" />: 296 CH
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" onchange="return viewmap();" type="checkbox" id="cboos" value="option1">
                                                <label for="cboos" class="custom-control-label">OOS >=5%</label>
                                            </div>
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" onchange="return viewmap();" type="checkbox" id="cbsos" value="option1">
                                                <label for="cbsos" class="custom-control-label">SOS < 40%</label>
                                            </div>
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" onchange="return viewmap();" type="checkbox" checked="checked" id="cbso" value="option1">
                                                <label for="cbso" class="custom-control-label">D/Số > 1 tỷ </label>
                                            </div>
                                        </td>
                                         <td style="padding-left: 10px;">
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" onchange="return viewmap();" type="checkbox" id="cbb2c" value="option1">
                                                <label for="cbb2c" class="custom-control-label">(GT) Sử dụng App B2C </label>
                                            </div>
                                        </td>
                                        <td style="padding-left: 10px;">
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" onchange="return viewmap();" type="checkbox" id="cbar" value="option1">
                                                <label for="cbar" class="custom-control-label">(GT) Đạt T/Bày </label>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align: left;">
                                <table>
                                    <tr>
                                        <td>
                                            <img src="Images/map_blue.png" />
                                        </td>
                                        <td>
                                            <div class="custom-control custom-checkbox">
                                                <input class="custom-control-input" onchange="return viewmap();" checked="checked" type="checkbox" id="cbbt" value="option1">
                                                <label id="lbbt" for="cbbt" class="custom-control-label">CH khác: 700 CH</label>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <div class="custom-control custom-checkbox">
                                    <input class="custom-control-input" onchange="return viewmap();" checked="checked" type="checkbox" id="cbmaprada" value="option1">
                                    <label id="lbmaprada" for="cbmaprada" class="custom-control-label">Bản đồ tổng quan</label>
                                </div>
                            </td>
                            <td style="text-align: right;">
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </table>
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
                                <label>Cửa hàng:</label>
                                <asp:DropDownList runat="server" ID="DropDownList4" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Cửa hàng 1</asp:ListItem>
                                    <asp:ListItem Value="3">Cửa hàng 2</asp:ListItem>
                                    <asp:ListItem Value="4">Cửa hàng 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.card-body -->
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-3" data-select2-id="30">
                            <label class="btn btn-primary">Tìm kiếm</label>
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

            <div style="position: fixed; top: 105px; bottom: 0px; right: 0px; left: 0px; min-width: 600px; z-index: 100">
                <div id="map" style="width: 100%; height: 100%; position: relative;"></div>
            </div>
            <script src="/Scripts/GMap.js"></script>
            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwgPnM_mpRuCDWgP2I8MCJ3EmkLiT9bGE&callback=GMap.init">
            </script>

            <script src="/Scripts/markerclusterer.js"></script>
        </div>

        <div class="modal fade show" id="modal-xl" style="display: none; z-index: 9999999999999;" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header" style="padding: 5px 11px 2px 9px;">
                        <h4 class="modal-title">Thông tin chi tiết cửa hàng</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" style="padding: 0px !important;">

                        <section class="content">
                            <div class="container-fluid">
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="vertical-align: top;">
                                            <table class="table">
                                                <tr>
                                                    <th style="text-align: left;">Mã cửa hàng
                                                    </th>
                                                    <td style="text-align: left;">ShopCode0001</td>
                                                    <th style="text-align: left;">Tên cửa hàng
                                                    </th>
                                                    <td style="text-align: left;">Coop Food- NGUYỄN THỊ DỊNH</td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">Địa chỉ
                                                    </th>
                                                    <td colspan="3" style="text-align: left;">2 Hùng Vương,Phường Cam Lộc,TP. Cam Ranh,Tỉnh Khánh Hòa	</td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">Loại cửa hàng</th>
                                                    <td style="text-align: left;">Gold</td>
                                                    <th style="text-align: left;">Loại hình</th>
                                                    <td style="text-align: left;">Supermarket</td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">Chuỗi siêu thị</th>
                                                    <td style="text-align: left;">BigC</td>
                                                    <th style="text-align: left;">Khu vực</th>
                                                    <td style="text-align: left;">Thành thị</td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">Leader</th>
                                                    <td style="text-align: left;">Trần văn A</td>
                                                    <th style="text-align: left;">Quản lý</th>
                                                    <td style="text-align: left;">Trần văn B</td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">KPI</th>
                                                    <td colspan="3" style="text-align: left;"><b>OOS</b> <b style="color: red;">6%</b> | <b style="padding-left: 10px;">SOS</b> <b style="color: red;">40%</b> | <b style="padding-left: 10px;">SellOut</b> <b style="color: blue;">2tỷ/tháng</b> | <b style="padding-left: 10px;">Audit</b> <b style="color: blue;">Đạt</b></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="vertical-align: top; text-align: center;">
                                            <img style="height: 247px; width: 100%;" src="../Images/store.jpg" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </section>
                        <section class="content">
                            <div class="container-fluid">
                                <div class="card card-primary card-outline card-tabs">
                                    <div class="card-header p-0 pt-1">
                                        <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" id="tabfieldforce_Tab" data-toggle="pill" href="#tabfieldforce" role="tab" aria-controls="tabfieldforce" aria-selected="true">DOANH SỐ</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="taboos_tab" data-toggle="pill" href="#taboos" onclick="return tab_oos()" role="tab" aria-controls="taboos" aria-selected="false">OOS</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tabsos_tab" data-toggle="pill" href="#tabsos" onclick="return tab_sos()" role="tab" aria-controls="tabsos" aria-selected="false">SOS</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tabivt_tab" data-toggle="pill" href="#tabivt" onclick="return tab_ivt()" role="tab" aria-controls="tabivt" aria-selected="false">INVENTORY</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tabhrm_Tab" data-toggle="pill" href="#tabhrm" onclick="return tab_hrm()" role="tab" aria-controls="tabhrm" aria-selected="false">HRM</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="tabhrm_Audit" data-toggle="pill" href="#tabaudit" onclick="return tab_audit()" role="tab" aria-controls="tabaudits" aria-selected="false">AUDIT</a>
                                            </li>
                                             <li class="nav-item">
                                                <a class="nav-link" id="tabb2c_Tab" data-toggle="pill" href="#tabb2c" onclick="return tab_b2c()" role="tab" aria-controls="tabb2c" aria-selected="false">(GT) APP B2C</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="card-body">
                                        <div class="tab-content">
                                            <div class="tab-pane fade show active" id="tabfieldforce" role="tabpanel" aria-labelledby="tabfieldforce">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="card">
                                                            <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                                                <p class="card-title" style="color: white; font-weight: bold;">
                                                                    Doanh số trong 3 tháng gần nhất ( tỉ)
                                                                </p>
                                                            </div>
                                                            <div class="card-body">
                                                                <div id="containerSellout"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="card">
                                                            <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                                                <p class="card-title" style="color: white; font-weight: bold;">
                                                                    Doanh số theo nhãn hàng ( tỉ)
                                                                </p>
                                                            </div>
                                                            <div class="card-body" style="height: 340px; overflow-y: auto;">
                                                                <table class="table" style="width: 100%;">
                                                                    <tr>
                                                                        <th>STT</th>
                                                                        <th>Nhãn hàng</th>
                                                                        <th>Tháng 1</th>
                                                                        <th>Tháng 2</th>
                                                                        <th>Tháng 3</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>1</td>
                                                                        <td>Nhãn hàng 1</td>
                                                                        <td>3</td>
                                                                        <td>4</td>
                                                                        <td>6</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>2</td>
                                                                        <td>Nhãn hàng 2</td>
                                                                        <td>3</td>
                                                                        <td>4</td>
                                                                        <td>6</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>3</td>
                                                                        <td>Nhãn hàng 3</td>
                                                                        <td>3</td>
                                                                        <td>4</td>
                                                                        <td>6</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>4</td>
                                                                        <td>Nhãn hàng 4</td>
                                                                        <td>3</td>
                                                                        <td>4</td>
                                                                        <td>6</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>5</td>
                                                                        <td>Nhãn hàng 5</td>
                                                                        <td>3</td>
                                                                        <td>4</td>
                                                                        <td>6</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>5</td>
                                                                        <td>Nhãn hàng 5</td>
                                                                        <td>3</td>
                                                                        <td>4</td>
                                                                        <td>6</td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade show" id="taboos" role="tabpanel" aria-labelledby="taboos">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="card">
                                                            <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                                                <p class="card-title" style="color: white; font-weight: bold;">
                                                                    Hết hàng trong 3 tháng gần nhất (%)
                                                                </p>
                                                            </div>
                                                            <div class="card-body">
                                                                <div id="containerOOS"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="card">
                                                            <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                                                <p class="card-title" style="color: white; font-weight: bold;">
                                                                    Hết hàng theo sản phẩm
                                                                </p>
                                                            </div>
                                                            <div class="card-body" style="height: 340px; overflow-y: auto;">
                                                                <table class="table" style="width: 100%;">
                                                                    <tr>
                                                                        <th>STT</th>
                                                                        <th>Sản phẩm</th>
                                                                        <th>Tháng 1</th>
                                                                        <th>Tháng 2</th>
                                                                        <th>Tháng 3</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>1</td>
                                                                        <td>Sản phẩm 1</td>
                                                                        <td>OOS</td>
                                                                        <td>OOS</td>
                                                                        <td></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>2</td>
                                                                        <td>Sản phẩm 2</td>
                                                                        <td>OOS</td>
                                                                        <td></td>
                                                                        <td>OOS</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>3</td>
                                                                        <td>Sản phẩm 3</td>
                                                                        <td></td>
                                                                        <td></td>
                                                                        <td>OOS</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>4</td>
                                                                        <td>Sản phẩm 4</td>
                                                                        <td></td>
                                                                        <td>OOS</td>
                                                                        <td></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>5</td>
                                                                        <td>Sản phẩm 5 <span style="color:Red;font-size:Large;font-weight:bold;">*</span></td>
                                                                        <td>OOS</td>
                                                                        <td>OOS</td>
                                                                        <td>OOS</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>6</td>
                                                                        <td>Nhãn hàng 6</td>
                                                                        <td>OOS</td>
                                                                        <td></td>
                                                                        <td></td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade show" id="tabsos" role="tabpanel" aria-labelledby="tabsos">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="card">
                                                            <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                                                <p class="card-title" style="color: white; font-weight: bold;">
                                                                    Thị phần T/bày trong 3 tháng gần nhất (%)
                                                                </p>
                                                            </div>
                                                            <div class="card-body">
                                                                <div id="containerSOS"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="card">
                                                            <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                                                <p class="card-title" style="color: white; font-weight: bold;">
                                                                    Thị phần t/bày theo ngành hàng
                                                                </p>
                                                            </div>
                                                            <div class="card-body" style="height: 340px; overflow-y: auto;">
                                                                <table class="table" style="width: 100%;">
                                                                    <tr>
                                                                        <th>STT</th>
                                                                        <th>Ngành hàng</th>
                                                                        <th>Tháng 1</th>
                                                                        <th>Tháng 2</th>
                                                                        <th>Tháng 3</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>1</td>
                                                                        <td>Ngành hàng 1</td>
                                                                        <td style="color: red;">40%</td>
                                                                        <td>45%</td>
                                                                        <td>50%</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>2</td>
                                                                        <td>Ngành hàng 2</td>
                                                                        <td>45%</td>
                                                                        <td>50%</td>
                                                                        <td style="color: red;">40%</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>3</td>
                                                                        <td>Ngành hàng 3</td>
                                                                        <td style="color: red;">40%</td>
                                                                        <td>45%</td>
                                                                        <td>50%</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>4</td>
                                                                        <td>Ngành hàng 4</td>
                                                                        <td>45%</td>
                                                                        <td>50%</td>
                                                                        <td style="color: red;">40%</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>5</td>
                                                                        <td>Ngành hàng 5</td>
                                                                        <td style="color: red;">40%</td>
                                                                        <td>45%</td>
                                                                        <td>50%</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>6</td>
                                                                        <td>Ngành hàng 6</td>
                                                                        <td>45%</td>
                                                                        <td>50%</td>
                                                                        <td style="color: red;">40%</td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade show" id="tabivt" role="tabpanel" aria-labelledby="tabivt">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="card">
                                                            <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                                                <p class="card-title" style="color: white; font-weight: bold;">
                                                                    Top 10 sản phẩm WOS cao nhất
                                                                </p>
                                                            </div>
                                                            <div class="card-body" style="height: 340px; overflow-y: auto;">
                                                                <table class="table" style="width: 100%;">
                                                                    <tr>
                                                                        <th>STT</th>
                                                                        <th>Sản phẩm</th>
                                                                        <th>Tháng 1</th>
                                                                        <th>Tháng 2</th>
                                                                        <th>Tháng 3</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>1</td>
                                                                        <td>Sản phẩm 1</td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>2</td>
                                                                        <td>Sản phẩm 2</td>
                                                                        <td>2</td>
                                                                        <td style="color: red;">7</td>
                                                                        <td>2.5</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>3</td>
                                                                        <td>Sản phẩm 3</td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>4</td>
                                                                        <td>Sản phẩm 4</td>
                                                                        <td>2</td>
                                                                        <td style="color: red;">7</td>
                                                                        <td>2.5</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>5</td>
                                                                        <td>Sản phẩm 5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>6</td>
                                                                        <td>Sản phẩm 6 <span style="color:Red;font-size:Large;font-weight:bold;">*</span></td>
                                                                        <td>2</td>
                                                                        <td style="color: red;">7</td>
                                                                        <td>2.5</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>7</td>
                                                                        <td>Sản phẩm 7</td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>8</td>
                                                                        <td>Sản phẩm 8</td>
                                                                        <td>2</td>
                                                                        <td style="color: red;">7</td>
                                                                        <td>2.5</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>9</td>
                                                                        <td>Sản phẩm 9 <span style="color:Red;font-size:Large;font-weight:bold;">*</span></td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                        <td style="color: red;">10.5</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>10</td>
                                                                        <td>Sản phẩm 10</td>
                                                                        <td>2</td>
                                                                        <td style="color: red;">7</td>
                                                                        <td>2.5</td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="card">
                                                            <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                                                <p class="card-title" style="color: white; font-weight: bold;">
                                                                    Top 10 sản phẩm WOS thấp nhất
                                                                </p>
                                                            </div>
                                                            <div class="card-body" style="height: 340px; overflow-y: auto;">
                                                                <table class="table" style="width: 100%;">
                                                                    <tr>
                                                                        <th>STT</th>
                                                                        <th>Sản phẩm</th>
                                                                        <th>Tháng 1</th>
                                                                        <th>Tháng 2</th>
                                                                        <th>Tháng 3</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>1</td>
                                                                        <td>Sản phẩm 1 <span style="color:Red;font-size:Large;font-weight:bold;">*</span></td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.2</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>2</td>
                                                                        <td>Sản phẩm 2</td>
                                                                        <td style="color: red;">1</td>
                                                                        <td style="color: red;">1.5</td>
                                                                        <td>3</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>3</td>
                                                                        <td>Sản phẩm 3</td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.2</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>4</td>
                                                                        <td>Sản phẩm 4</td>
                                                                        <td style="color: red;">1</td>
                                                                        <td style="color: red;">1.5</td>
                                                                        <td>3</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>5</td>
                                                                        <td>Sản phẩm 5</td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.2</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>6</td>
                                                                        <td>Sản phẩm 6</td>
                                                                        <td style="color: red;">1</td>
                                                                        <td style="color: red;">1.5</td>
                                                                        <td>3</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>7</td>
                                                                        <td>Sản phẩm 7</td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.2</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>8</td>
                                                                        <td>Sản phẩm 8</td>
                                                                        <td style="color: red;">1</td>
                                                                        <td style="color: red;">1.5</td>
                                                                        <td>3</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>9</td>
                                                                        <td>Sản phẩm 9</td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.5</td>
                                                                        <td style="color: red;">0.2</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>10</td>
                                                                        <td>Sản phẩm 10</td>
                                                                        <td style="color: red;">1</td>
                                                                        <td style="color: red;">1.5</td>
                                                                        <td>3</td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane fade show" id="tabhrm" role="tabpanel" aria-labelledby="tabhrm">
                                                <div class="card card-solid" style="height: 391px;">
                                                    <div class="card-body pb-0">
                                                        <div class="row d-flex align-items-stretch">
                                                            <div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch">
                                                                <div class="card bg-light">
                                                                    <div class="card-header text-muted border-bottom-0">
                                                                        SALE REP
                                                                   
                                                                    </div>
                                                                    <div class="card-body pt-0">
                                                                        <div class="row">
                                                                            <div class="col-7">
                                                                                <h2 class="lead"><b>Trần Văn A</b></h2>
                                                                                <%--<p class="text-muted text-sm"><b>About: </b>Sale Rep </p>--%>
                                                                                <ul class="ml-4 mb-0 fa-ul text-muted">
                                                                                    <li class="small"><span class="fa-li"><i class="fas fa-lg fa-building"></i></span>Address: Số 39 Đường Trần Đại Nghĩa, Phường 4, Tp. Vĩnh Long</li>
                                                                                    <li class="small"><span class="fa-li"><i class="fas fa-lg fa-phone"></i></span>Phone #: + 84 - 99 99 99 99</li>
                                                                                </ul>
                                                                                <table class="table" style="font-size: 80%; margin-top: 10px;">
                                                                                    <tr>
                                                                                        <th>T2</th>
                                                                                        <th>T3</th>
                                                                                        <th>T4</th>
                                                                                        <th>T5</th>
                                                                                        <th>T6</th>
                                                                                        <th>T7</th>
                                                                                        <th>CN</th>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>C1</td>
                                                                                        <td>C2</td>
                                                                                        <td>OFF</td>
                                                                                        <td>C1</td>
                                                                                        <td>C1</td>
                                                                                        <td>C1</td>
                                                                                        <td>C1</td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                            <div class="col-5 text-center">
                                                                                <img src="../AdminLTE/dist/img/avatar5.png" style="width: 128px;" alt="" class="img-circle img-fluid">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-footer">
                                                                        <div class="text-right">
                                                                            <a href="#" class="btn btn-sm bg-teal">
                                                                                <i class="fas fa-comments"></i>
                                                                            </a>
                                                                            <a href="#" class="btn btn-sm btn-primary">
                                                                                <i class="fas fa-user"></i>View Profile  </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch">
                                                                <div class="card bg-light">
                                                                    <div class="card-header text-muted border-bottom-0">
                                                                        MERCHANDISE
                                                                   
                                                                    </div>
                                                                    <div class="card-body pt-0">
                                                                        <div class="row">
                                                                            <div class="col-7">
                                                                                <h2 class="lead"><b>Trần Văn B</b></h2>
                                                                                <%--<p class="text-muted text-sm"><b>About: </b>MERCHANDISE </p>--%>
                                                                                <ul class="ml-4 mb-0 fa-ul text-muted">
                                                                                    <li class="small"><span class="fa-li"><i class="fas fa-lg fa-building"></i></span>Address: Số 39 Đường Trần Đại Nghĩa, Phường 4, Tp. Vĩnh Long</li>
                                                                                    <li class="small"><span class="fa-li"><i class="fas fa-lg fa-phone"></i></span>Phone #: + 84 - 99 99 99 99</li>
                                                                                </ul>
                                                                                <table class="table" style="font-size: 80%; margin-top: 10px;">
                                                                                    <tr>
                                                                                        <th>T2</th>
                                                                                        <th>T3</th>
                                                                                        <th>T4</th>
                                                                                        <th>T5</th>
                                                                                        <th>T6</th>
                                                                                        <th>T7</th>
                                                                                        <th>CN</th>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>C1</td>
                                                                                        <td>C2</td>
                                                                                        <td>OFF</td>
                                                                                        <td>C1</td>
                                                                                        <td>C1</td>
                                                                                        <td>C1</td>
                                                                                        <td>C1</td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                            <div class="col-5 text-center">
                                                                                <img src="../AdminLTE/dist/img/avatar5.png" style="width: 128px;" alt="" class="img-circle img-fluid">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-footer">
                                                                        <div class="text-right">
                                                                            <a href="#" class="btn btn-sm bg-teal">
                                                                                <i class="fas fa-comments"></i>
                                                                            </a>
                                                                            <a href="#" class="btn btn-sm btn-primary">
                                                                                <i class="fas fa-user"></i>View Profile  </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch">
                                                                <div class="card bg-light">
                                                                    <div class="card-header text-muted border-bottom-0">
                                                                        TEAMLEADER
                                                                   
                                                                    </div>
                                                                    <div class="card-body pt-0">
                                                                        <div class="row">
                                                                            <div class="col-7">
                                                                                <h2 class="lead"><b>Trần Văn C</b></h2>
                                                                                <%--<p class="text-muted text-sm"><b>About: </b>MERCHANDISE </p>--%>
                                                                                <ul class="ml-4 mb-0 fa-ul text-muted">
                                                                                    <li class="small"><span class="fa-li"><i class="fas fa-lg fa-building"></i></span>Address: Số 39 Đường Trần Đại Nghĩa, Phường 4, Tp. Vĩnh Long</li>
                                                                                    <li class="small"><span class="fa-li"><i class="fas fa-lg fa-phone"></i></span>Phone #: + 84 - 99 99 99 99</li>
                                                                                </ul>
                                                                            </div>
                                                                            <div class="col-5 text-center">
                                                                                <img src="../AdminLTE/dist/img/avatar5.png" style="width: 128px;" alt="" class="img-circle img-fluid">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="card-footer">
                                                                        <div class="text-right">
                                                                            <a href="#" class="btn btn-sm bg-teal">
                                                                                <i class="fas fa-comments"></i>
                                                                            </a>
                                                                            <a href="#" class="btn btn-sm btn-primary">
                                                                                <i class="fas fa-user"></i>View Profile  </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
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
                    </div>
                    <div class="modal-footer justify-content-between" style="display: none;">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

    </section>
    <script>
        function view_report(shopcode) {
            $('#lbtesstt').html(shopcode);
            // SELLOUT
            Highcharts.chart('containerSellout', {
                chart: { type: 'column', height: 300 },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['T1', 'T2', 'T3'],
                    crosshair: true
                },
                yAxis:
                {
                    min: 0,
                    title: {
                        text: 'Tỉ VND'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} tỉ</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 10) {
                                    return '<span style="color: red">' + this.y + '</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + '</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: true },
                credits: { enabled: false },
                series: [{
                    name: 'Doanh số',
                    data: [9, 15, 16]
                },
                {
                    name: 'Đổi quà (MT) / trả thưởng (GT)',
                    data: [5, 3, 4],
                    color: '#FF530D',
                }
                ]
            });

            // SOS
            Highcharts.chart('containerSOS', {
                chart: { type: 'column', height: 300 },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['T1', 'T2', 'T3'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Tỉ lệ %'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 40) {
                                    return '<span style="color: red">' + this.y + ' %</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + ' %</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: true },
                credits: { enabled: false },
                series: [{
                    name: 'SOS',
                    data: [45, 50, 43]
                },
                {
                    name: 'Đối thủ 1',
                    data: [30, 39, 24],
                    color: '#25D2CE'
                },
                {
                    name: 'Đối thủ 2',
                    data: [12, 12, 15],
                    color: '#D25725'
                }
                ]
            });
        }
        function tab_oos() {
            //OOS
            Highcharts.chart('containerOOS', {
                chart: { type: 'column', height: 300 },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['T1', 'T2', 'T3'],
                    crosshair: true
                },
                yAxis:
                {
                    min: 0,
                    title: {
                        text: '%'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y > 5) {
                                    return '<span style="color: red">' + this.y + '</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + '</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: false },
                credits: { enabled: false },
                series: [{
                    name: 'Hết hàng',
                    data: [9, 7, 4]
                }
                ]
            });
        }
        function viewmap() {
            var _oos = 0; if ($('#cboos').is(":checked")) {
                _oos = 1;
            }
            var _sos = 0; if ($('#cbsos').is(":checked")) {
                _sos = 1;
            }
            var _so = 0; if ($('#cbso').is(":checked") || $('#cbb2c').is(":checked") || $('#cbar').is(":checked")) {
                _so = 1;
            }
            var _bt = 0; if ($('#cbbt').is(":checked")) {
                _bt = 1;
            }
            var _maprado = 0; if ($('#cbmaprada').is(":checked")) {
                _maprado = 1;
            }
            $.ajax({
                url: "/api/digitalmap.ashx?OOS=" + _oos + "&SOS=" + _sos + "&SO=" + _so + "&BT=" + _bt,
                type: "POST",
                success: function (data) {
                    try {
                        GMap.clearShops();
                    } catch (e) {
                    }
                    try {
                        GMap.Markers.clear();
                    } catch (e) {
                    }


                    if (_maprado == 0) {
                        if (data && data.length && data.length > 0) {
                            for (var j = 0; j < data.length; j++) {
                                var _content = '<div id="content">' +
                                    '<div id="siteNotice">' +
                                    '</div>' +
                                    '<h5 id="firstHeading" class="firstHeading">' + data[j].ShopName + '</h5>' +
                                    '<div id="bodyContent">' +
                                    '<p>' +
                                    '<b>ShopCode: </b>' + data[j].ShopCode + '<br/>' +
                                    '<b>Address: </b>' + data[j].ShopAddress + '<br/>' +
                                    '</p>' +
                                    "<button type=\"button\" class=\"btn btn-default\" data-toggle=\"modal\" data-target=\"#modal-xl\" onclick=\"return view_report('" + data[j].ShopCode + "')\" > Xem chi tiết </button>" +
                                    //"<button onclick=\"return view_report('" + data[j].ShopCode + "')\">Xem chi tiết</button>" +
                                    '</div>' +
                                    '</div>';
                                GMap.Markers.add(data[j].ShopCode, data[j].LocationLatitude, data[j].LocationLongitude, data[j].ShopCode, _content, data[j].icon);
                            }
                        }
                    }

                    else if (_maprado == 1) {
                        if (data && data.length && data.length > 0) {
                            for (var j = 0; j < data.length; j++) {
                                GMap.addShop(data[j]);
                            }
                        }
                        GMap.loadClusterer();
                    }
                },
                error: function () {
                }
            });
        }
    </script>
</asp:Content>
