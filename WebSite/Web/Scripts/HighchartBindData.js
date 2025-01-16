function chart_column_multi_yAxis(_idchart, _category_array, _p_yAxis_title,s_yAxis_title) {
    Highcharts.chart(_idchart, {
        chart: {
            zoomType: 'xy',
            height: 400
        },
        credits: { enabled: false },
        title: { text: null },
        subtitle: { text: null, align: 'left' },
        xAxis: [{
            categories: _category_array,//['Nationwide', 'C1', 'C2'],
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
                text: _p_yAxis_title,//'Tỉ lệ Audit',
                style: {
                    color: '#D26E25'
                }
            },
            opposite: true

        }, { // Secondary yAxis
            gridLineWidth: 0,
            title: {
                text: s_yAxis_title,//'Số lượt Audit',
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
            name: 'Chỉ tiêu',
            type: 'column',
            yAxis: 1,
            data: [33, 34, 32],
            tooltip: {
                valueSuffix: 'k lượt'
            },
            dataLabels: {
                enabled: true,
                format: '{y}k'
            }

        },
        {
            name: 'Audit',
            type: 'column',
            color: '#226E40',
            yAxis: 1,
            data: [30, 31, 18],
            tooltip: {
                valueSuffix: 'k lượt'
            },
            dataLabels: {
                enabled: true,
                format: '{y}k'
            },
            //stack: 'TC'
        },
        {
            name: 'Tỉ lệ Audit',
            type: 'spline',
            yAxis: 0,
            data: [99, 99, 63],
            marker: {
                enabled: false
            },
            tooltip: {
                valueSuffix: ' %'
            },
            dataLabels: {
                enabled: true,
                format: '{y} %'
            }
        }
        ]
    });
}