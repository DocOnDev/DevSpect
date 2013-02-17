//<![CDATA[ 
var chart;
var chart;
$(document).ready(function() {
  _dataSeries = (typeof dataSeries != 'undefined' ? dataSeries : []);
  _chartTitle = (typeof chartTitle != 'undefined' ? chartTitle : 'Cumulative Flow Diagram');

  chart = new Highcharts.Chart({
    chart: { renderTo: 'container', type: 'column' },
    title: { text: _chartTitle },
    xAxis: { type: 'datetime',tickInterval: (24 * 3600 * 1000 * 7), 
      dateTimeLabelFormats: {
       week: '%d-%b-%Y',
       month: '%b \'%y',
       year: '%Y'
     } },
    yAxis: { min: 0, title: { text: 'Points' } },
    legend: {
      layout: 'vertical',
      backgroundColor: '#FFFFFF',
      align: 'left',
      verticalAlign: 'top',
      x: 100,
      y: 70,
      floating: true,
      shadow: true
    },
    tooltip: { formatter: function() { return ''+ Highcharts.dateFormat('%d-%b', this.x) +': '+ Highcharts.numberFormat(this.y, 0, ',') +' points'; } },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },
    series: _dataSeries  });
});
    //]]>  
