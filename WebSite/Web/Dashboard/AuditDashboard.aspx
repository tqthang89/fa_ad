<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="AuditDashboard.aspx.cs" Inherits="ECS_Web.Dashboard.AuditDashboard" %>

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

        div#div_card_info12 {
            display: none;
        }
    </style>
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="../Scripts/HighchartBindData.js"></script>
    <script>
        $(document).ready(function () {
            //$("a.nav-link").first().trigger("click");
            window.setTimeout(function () {
                tab_audit();
            }, 300);
        });

        function tab_audit() {
            var chartQuery = {
                CycleId: $('#ContentPlaceHolder1_ddlCycle option:selected').val(),
                AreaId: $('#ContentPlaceHolder1_ddlArea option:selected').val(),
                ProvinceId: $('#ContentPlaceHolder1_ddlProvince option:selected').val(),
                MDOId: $('#ContentPlaceHolder1_ddlMDO option:selected').val(),
                PNGId: $('#ContentPlaceHolder1_ddlPNG option:selected').val()
            };
            //toastr.success(chartQuery.CycleId + "_" + chartQuery.AreaId + "_"+ chartQuery.ProvinceId );
            
            //Process Audit
            $.ajax({
                url: 'api/getdatachart?FUNCTION=PROCESSAUDIT',
                type: 'POST',
                data: chartQuery,
                success: function (data_chart1) {

                    var data_chart = data_chart1.Content;

                    //Process Audit by AuditResult
                    //public int process_all_noaudit_value { set; get; }
                    //public int process_all_noaudit_percent { set; get; }
                    //public int process_all_tc_value { set; get; }
                    //public int process_all_tc_percent { set; get; }
                    //public int process_all_ktc_value { set; get; }
                    //public int process_all_ktc_percent { set; get; }
                    $('#p_label_process').text('Tiến độ Audit - ' + data_chart.process_all_ch + " CH");
                    Highcharts.chart('containerProcessAuditAll', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text:null,// 'Tiến độ Audit - ' + data_chart.process_all_ch + " CH",
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.y} %</b>'
                        },
                        accessibility: {
                            point: {
                                valueSuffix: '%'
                            }
                        },
                        credits: { enabled: false },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                    enabled: true,
                                    format: '<b>{point.name}</b>: {point.y} %'
                                }
                            }
                        },
                        series: [{
                            name: 'Tỉ lệ',
                            colorByPoint: true,
                            data: [{
                                name: 'Chưa Audit (' + data_chart.process_all_noaudit_value + ' CH)',
                                y: data_chart.process_all_noaudit_percent,
                                sliced: true,
                                selected: true, color: '#85C1E9'
                            }, {
                                name: 'Audit TC (' + data_chart.process_all_tc_value + ' CH)',
                                y: data_chart.process_all_tc_percent,
                                color:'#82E0AA'
                                }
                                , {
                                    name: 'Audit KTC (' + data_chart.process_all_ktc_value + ' CH)',
                                    y: data_chart.process_all_ktc_percent,
                                    color:'#EC7063'
                                }]
                        }]
                    });

                    Highcharts.chart('containerProcessAudit', {
                        chart: {
                            zoomType: 'xy',
                            height: 400
                        },
                        credits: { enabled: false },
                        title: { text: null },
                        subtitle: { text: null, align: 'left' },
                        xAxis: [{
                            categories: data_chart.process_label,// ['Tổng', 'C1', 'C2', 'C3', 'C4', 'C5', 'C6'],
                            crosshair: true
                        }],
                        yAxis: [{ // Primary yAxis
                            labels: {
                                format: '{value} %',
                                style: {
                                    color: '#D26E25'
                                }
                            },
                            title: {
                                text: 'Tỉ lệ Audit',
                                style: {
                                    color: '#D26E25'
                                }
                            },
                            opposite: true

                        }, { // Secondary yAxis
                            gridLineWidth: 0,
                            title: {
                                text: 'Số CH Audit',
                                style: {
                                    color: Highcharts.getOptions().colors[0]
                                }
                            },
                            labels: {
                                format: '{value} CH',
                                style: {
                                    color: Highcharts.getOptions().colors[0]
                                }
                            }

                        }
                        ],
                        tooltip: {
                            shared: true
                        },
                        plotOptions: {
                            column: {
                                pointPadding: 0.2,
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: true,
                                    crop: false,
                                    overflow: 'none'
                                },
                                stacking: 'normal'
                            }
                        },
                        series: [{
                            name: 'Chỉ tiêu',
                            type: 'column',
                            yAxis: 1,
                            data: data_chart.process_target,// [750, 100, 100, 100, 100, 100, 100],
                            tooltip: {
                                valueSuffix: ' CH'
                            },
                            dataLabels: {
                                enabled: true,
                                format: '{y} CH'
                            }
                        },
                        
                        {
                            name: 'KTC',
                            type: 'column',
                            color: '#FF0000',
                            yAxis: 1,
                            data: data_chart.process_ktc,//[100, 15, 18, 15, 16, 12, 23],
                            tooltip: {
                                valueSuffix: 'CH'
                            },
                            dataLabels: {
                                enabled: false,
                                //format: '{y} CH'
                            },
                            stack: 'AUDIT'
                            },
                            {
                                name: 'TC',
                                type: 'column',
                                color: '#226E40',
                                yAxis: 1,
                                data: data_chart.process_tc,// [100, 15, 18, 15, 16, 12, 23],
                                tooltip: {
                                    valueSuffix: 'CH'
                                },
                                dataLabels: {
                                    enabled: false,
                                    //format: '{y} CH'
                                },
                                stack: 'AUDIT'
                            },
                        {
                            name: 'Tỉ lệ Audit',
                            type: 'spline',
                            yAxis: 0,
                            data: data_chart.process_percent,// [18, 15, 18, 15, 16, 12, 23],
                            marker: {
                                enabled: false
                            },
                            tooltip: {
                                valueSuffix: ' %'
                            },
                            dataLabels: {
                                enabled: true,
                                format: '{y} %'
                            },
                            color:'#AF7AC5'
                        }
                        ]
                    });


                    //Process Audit by AuditResult
                    Highcharts.chart('containerProcessAuditByAuditResult', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: null
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.y} %</b>'
                        },
                        accessibility: {
                            point: {
                                valueSuffix: '%'
                            }
                        },
                        credits: { enabled: false },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                    enabled: true,
                                    format: '<b>{point.name}</b>: {point.y} %'
                                }
                            }
                        },
                        series: [{
                            name: 'Tỉ lệ',
                            colorByPoint: true,
                            data: [{
                                name: 'Audit TC (' + data_chart.process_tc_label+' CH)',
                                y: data_chart.process_tc_percent,
                                sliced: true,
                                selected: true,
                                color:'#82E0AA'
                            }, {
                                name: 'Audit KTC (' + data_chart.process_ktc_label +' CH)',
                                y: data_chart.process_ktc_percent,
                                color: '#EC7063'
                            }]
                        }]
                    });


                    // Process Audit by PlanOgram
                    Highcharts.chart('containerSOSAudit', {
                        chart: {
                            zoomType: 'xy',
                            height: 400
                        },
                        credits: { enabled: false },
                        title: { text: null },
                        subtitle: { text: null, align: 'left' },
                        xAxis: [{
                            categories: data_chart.passaudit_label,// ['Tổng', 'DIAMOND', 'GOLD', 'TITAN'],
                            crosshair: true
                        }],
                        yAxis: [{ // Primary yAxis
                            labels: {
                                format: '{value} %',
                                style: {
                                    color: '#D26E25'
                                }
                            },
                            title: {
                                text: 'Tỉ lệ Đạt',
                                style: {
                                    color: '#D26E25'
                                }
                            },
                            opposite: true

                        }, { // Secondary yAxis
                            gridLineWidth: 0,
                            title: {
                                text: 'Số CH',
                                style: {
                                    color: Highcharts.getOptions().colors[0]
                                }
                            },
                            labels: {
                                format: '{value}k',
                                style: {
                                    color: Highcharts.getOptions().colors[0]
                                }
                            }

                        }
                        ],
                        tooltip: {
                            shared: true
                        },
                        plotOptions: {
                            column: {
                                pointPadding: 0.2,
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: true,
                                    crop: false,
                                    overflow: 'none'
                                },
                                //stacking: 'normal'
                            }
                        },
                        series: [{
                            name: 'Audit',
                            type: 'column',
                            yAxis: 1,
                            data: data_chart.passaudit_target,// [33, 34, 32, 35],
                            tooltip: {
                                valueSuffix: ' CH'
                            },
                            dataLabels: {
                                enabled: true,
                                format: '{y} CH'
                            }

                        },
                        {
                            name: 'Đạt',
                            type: 'column',
                            color: '#226E40',
                            yAxis: 1,
                            data: data_chart.passaudit_value,//  [30, 31, 18, 19],
                            tooltip: {
                                valueSuffix: ' CH'
                            },
                            dataLabels: {
                                enabled: true,
                                format: '{y} CH'
                            },
                            //stack: 'TC'
                        },
                        {
                            name: 'Tỉ lệ Đạt',
                            type: 'spline',
                            yAxis: 0,
                            data: data_chart.passaudit_percent,// [99, 99, 63, 67],
                            marker: {
                                enabled: false
                            },
                            tooltip: {
                                valueSuffix: ' %'
                            },
                            dataLabels: {
                                enabled: true,
                                format: '{y} %'
                            },
                            color:'#AF7AC5'
                        }
                        ]
                    });

                }
            });

            

            


            

            // PassKPIAudit
            Highcharts.chart('containerPassKPIAudit', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['KPI1'],
                    crosshair: true
                },
                yAxis:
                {
                    min: 0,
                    title: {
                        text: '% đạt'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y} %</b></td></tr>',
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
                                if (this.point.y < 80) {
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
                series: [
                    {
                        name: 'Nhãn hàng',
                        data: [67]
                    },
                    {
                        name: 'Tổng Facing',
                        data: [90]
                    },
                    {
                        name: 'Facing trên Nhãn',
                        data: [60],
                        color: '#FF530D',
                    },
                    {
                        name: 'Đối thủ & liền khối',
                        data: [60],
                    },
                    {
                        name: 'Liền nhãn',
                        data: [60],
                    },
                    {
                        name: 'POSM',
                        data: [60],
                    }
                ]
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Dashboard tổng hợp</h3>

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
                                </asp:DropDownList>
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
                                <asp:DropDownList runat="server" ID="ddlProvince" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
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
                        <div class="col-lg-2" style="display: none;">

                            <div class="form-group" data-select2-id="29">
                                <label style="color: brown;">Timegone</label>
                                <div class="progress-group" style="text-align: left;">
                                    40%
                               
                                            <span class="float-right"><b>12</b>/30 ngày</span>
                                    <div class="progress progress-sm">
                                        <div class="progress-bar bg-success" style="width: 40%"></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-2">
                            <input type="button" class="btn btn-primary" value="Tìm kiếm" onclick="return tab_audit()">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="card card-primary card-outline card-tabs">
                <div class="card-body">
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="tabaudit" role="tabpanel" aria-labelledby="tabaudit">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; " id="p_label_process">
                                                <%--Tiến độ Audit--%>
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerProcessAuditAll"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>

                                <div class="col-md-8">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white;">
                                                Tiến độ Audit theo vùng
                                            </p>

                                            <div class="card-tools">

                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerProcessAudit"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white;">
                                                Thống kê trạng thái Audit
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerProcessAuditByAuditResult"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; ">
                                                Thống kê số lượng đạt theo gói TB
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerSOSAudit"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6" style="display:none;">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Tỉ lệ đạt trưng bày từng KPI
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerPassKPIAudit"></div>
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

</asp:Content>
