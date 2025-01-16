<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="DigitalMapAudit.aspx.cs" Inherits="ECS_Web.DigitalMapAudit" %>

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

        div.card-header {
            display: none;
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
                <div class="card-header" style="display: block !important;">
                    <table style="width: 100%;">
                        <tr>
                            <td style="text-align: left; width: 200px; font-weight: bold;">
                                <label id="lbt_0">Tổng: 0 CH</label></td>
                            <%--<td style="text-align: left;">
                                <img src="../images/map_blue.png" />
                                DIAMOND : 
                                <label id="lbt_1" style="font-weight: normal;">0 CH</label>
                            </td>
                            <td style="text-align: left;">
                                <img src="../images/map_yellow.png" />
                                GOLD : 
                                <label id="lbt_2" style="font-weight: normal;">0 CH</label>
                            </td>
                            <td style="text-align: left;">
                                <img src="../images/map_green.png" />
                                TITAN : 
                                <label id="lbt_3" style="font-weight: normal;">0 CH</label>
                            </td>--%>
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
            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwgPnM_mpRuCDWgP2I8MCJ3EmkLiT9bGE&callback=GMap.init&language=vi">
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
                                                    <td style="text-align: left; font-weight: normal;">
                                                        <label style="font-weight: normal; margin-bottom: 0px !important;" id="lb_ShopCode"></label>
                                                    </td>
                                                    <th style="text-align: left;">Tên cửa hàng
                                                    </th>
                                                    <td style="text-align: left; font-weight: normal;">
                                                        <label style="font-weight: normal; margin-bottom: 0px !important;" id="lb_sname"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">Địa chỉ
                                                    </th>
                                                    <td colspan="3" style="text-align: left; font-weight: normal;">
                                                        <label style="font-weight: normal; margin-bottom: 0px !important;" id="lb_ShopAddress"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">Loại cửa hàng</th>
                                                    <td style="text-align: left; font-weight: normal;">
                                                        <label style="font-weight: normal; margin-bottom: 0px !important;" id="lb_FormatName"></label>
                                                    </td>
                                                    <th style="text-align: left;">Loại hình</th>
                                                    <td style="text-align: left;">Đại lý</td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">Latitude</th>
                                                    <td style="text-align: left; font-weight: normal;">
                                                        <label style="font-weight: normal; margin-bottom: 0px !important;" id="lb_Lat1"></label>
                                                    </td>
                                                    <th style="text-align: left;">Longitude</th>
                                                    <td style="text-align: left; font-weight: normal;">
                                                        <label style="font-weight: normal; margin-bottom: 0px !important;" id="lb_Long1"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">Chủ CH</th>
                                                    <td style="text-align: left; font-weight: normal;">
                                                        <label style="font-weight: normal; margin-bottom: 0px !important;" id="lb_ContactName"></label>
                                                    </td>
                                                    <th style="text-align: left;">Số ĐT</th>
                                                    <td style="text-align: left; font-weight: normal;">
                                                        <label style="font-weight: normal; margin-bottom: 0px !important;" id="lb_ContactMobile"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th style="text-align: left;">KPI</th>
                                                    <td colspan="3" style="text-align: left;"><b style="">Audit</b> <b style="color: blue;">Đạt</b></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="vertical-align: top; text-align: center;">
                                            <img style="height: 247px; width: 100%;" id="img_overview" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </section>
                        <section class="content">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Kết quả trưng bày 6 tháng gần nhất
                                            </p>
                                        </div>
                                        <div class="card-body" style="height: 340px; overflow-y: auto;">
                                            <table id="myTable" class="table" style="width: 100%;">
                                                <thead>
                                                    <tr>
                                                        <th colspan="8">Kết quả Audit 6 tháng gần nhất</th>
                                                    </tr>
                                                    <tr>
                                                        <th>STT</th>
                                                        <th>Ngày viếng thăm</th>
                                                        <th>Auditer</th>
                                                        <th>T/Thái viếng thăm</th>
                                                        <th>Gói TB</th>
                                                        <th>Điểm</th>
                                                        <th>% Trả Thưởng</th>
                                                        <th>MDO/Sales</th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                            </table>
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

        $(document).ready(function () {
            viewmap();
        });

        function view_report(shopcode) {
            $.ajax({
                //url: "/api/digitalmap.ashx?OOS=" + _oos + "&SOS=" + _sos + "&SO=" + _so + "&BT=" + _bt,
                url: "/api/digitalmap.ashx?FUNTION=SHOPDETAIL&SHOPCODE=" + shopcode + '&CYCLEID=6',
                type: "POST",
                success: function (_data) {
                    $('#lb_ShopCode').text(shopcode);
                    console.log(_data);
                    // Info
                    var data_info = _data.Table;
                    if (data_info && data_info.length && data_info.length > 0) {
                        for (var j = 0; j < data_info.length; j++) {
                            $('#' + data_info[j].TTitle).text(data_info[j].TValue);
                        }
                    }
                    $('#img_overview').attr("src", data_info[0].Photo);
                    $('#myTable').find('tbody').empty();
                    var data_audit = _data.Table1;
                    if (data_audit && data_audit.length && data_audit.length > 0) {
                        for (var j = 0; j < data_audit.length; j++) {
                            $('#myTable').find('tbody').append('<tr>')
                                .append('<td>' + data_audit[j].RN + '</td>')
                                .append('<td>' + data_audit[j].AuditDate + '</td>')
                                .append('<td>' + data_audit[j].EmployeeName + '</td>')
                                .append('<td>' + data_audit[j].AuditResult + '</td>')
                                .append('<td>' + data_audit[j].PNG + '</td>')
                                .append('<td>' + data_audit[j].StoreCard + '</td>')
                                .append('<td>' + data_audit[j].PaymentPercent + '</td>')
                                .append('<td>' + data_audit[j].MVO + '</td>')
                                .append('</tr>');

                        }
                    }
                },
                error: function () {
                }
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
                //url: "/api/digitalmap.ashx?OOS=" + _oos + "&SOS=" + _sos + "&SO=" + _so + "&BT=" + _bt,
                url: "/api/digitalmap.ashx?FUNTION=MAP&CYCLEID=6",
                type: "POST",
                success: function (_data) {
                    try {
                        GMap.clearShops();
                    } catch (e) {
                    }
                    try {
                        GMap.Markers.clear();
                    } catch (e) {
                    }
                    var data = _data.Table;

                    if (_maprado == 0) {
                        if (data && data.length && data.length > 0) {
                            //var count_choose = 0;
                            for (var j = 0; j < data.length; j++) {
                                var _content = '<div id="content">' +
                                    '<div id="siteNotice">' +
                                    '</div>' +
                                    '<h5 id="firstHeading" class="firstHeading">' + data[j].ShopName + '</h5>' +
                                    '<div id="bodyContent">' +
                                    '<p>' +
                                    '<b>ShopId: </b>' + data[j].ShopId + '<br/>' +
                                    '<b>Address: </b>' + data[j].ShopAddress + '<br/>' +
                                    '</p>' +
                                    "<button type=\"button\" class=\"btn btn-default\" data-toggle=\"modal\" data-target=\"#modal-xl\" onclick=\"return view_report('" + data[j].ShopId + "')\" > Xem chi tiết </button>" +
                                    //"<button onclick=\"return view_report('" + data[j].ShopCode + "')\">Xem chi tiết</button>" +
                                    '</div>' +
                                    '</div>';
                                if (data[j].LocationLatitude != 0)
                                    GMap.Markers.add(data[j].ShopId, data[j].LocationLatitude, data[j].LocationLongitude, data[j].ShopCode, _content, data[j].icon);
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

                    // Summary
                    var data_summary = _data.Table1;
                    if (data_summary && data_summary.length && data_summary.length > 0) {
                        for (var j = 0; j < data_summary.length; j++) {
                            $('#lbt_' + data_summary[j].SFOSA).text(data_summary[j].CountShop);
                        }
                    }
                },
                error: function () {
                }
            });
        }
    </script>
</asp:Content>
