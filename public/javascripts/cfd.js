//<![CDATA[ 
var chart;

$(function () {
  $(document).ready(function() {
    _dataSeries = (typeof dataSeries != 'undefined' ? dataSeries : []);
    _chartTitle = (typeof chartTitle != 'undefined' ? chartTitle : 'Cumulative Flow Diagram');

    chart = new Highcharts.Chart({
      chart: { renderTo: 'container', type: 'area', zoomType: 'xy' },
      title: { text: _chartTitle },
      xAxis: { type: 'datetime', tickInterval: (24 * 3600 * 1000 ), 
        dateTimeLabelFormats: {
           day: '%d-%b-%Y',
           week: '%d-%b-%Y',
           month: '%b \'%y',
           year: '%Y'
       } },
      yAxis: { title: { text: 'Points' } },
      legend: {
        layout: 'vertical',
        backgroundColor: '#327aaf',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        shadow: true
      },
      tooltip: { formatter: function() { return ''+ Highcharts.dateFormat('%d-%b', this.x) +': '+ Highcharts.numberFormat(this.y, 0, ',') +' points'; } },
      plotOptions: {
        area: {
          stacking: 'normal',
          lineWidth: 1,
        }
      },
      series: _dataSeries
    });
  });
});

//]]>  
