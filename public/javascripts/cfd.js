//<![CDATA[ 
var chart;

$(function () {
  $(document).ready(function() {
    _xCat = (typeof xCat != 'undefined' ? xCat : []);
    _dataSeries = (typeof dataSeries != 'undefined' ? dataSeries : []);
    _chartTitle = (typeof chartTitle != 'undefined' ? chartTitle : 'Cumulative Flow Diagram');

    chart = new Highcharts.Chart({
      chart: { renderTo: 'container', type: 'area', zoomType: 'xy' },
      title: { text: _chartTitle },
      xAxis: { categories: _xCat, tickmarkPlacement: 'on', title: { enabled: false } },
      yAxis: { title: { text: 'Points' } },
      tooltip: { formatter: function() { return ''+ this.x +': '+ Highcharts.numberFormat(this.y, 0, ',') +' points'; } },
      plotOptions: {
        area: {
          stacking: 'normal',
          lineColor: '#666666',
          lineWidth: 1,
          marker: { lineWidth: 1, lineColor: '#666666' }
        }
      },
      series: _dataSeries
    });
  });
});
//]]>  
