//<![CDATA[ 
var chart;

$(function () {
  $(document).ready(function() {
    _dataSeries = (typeof dataSeries != 'undefined' ? dataSeries : []);
    _chartTitle = (typeof chartTitle != 'undefined' ? chartTitle : 'Cumulative Flow Diagram');

    chart = new Highcharts.Chart({
      chart: { renderTo: 'container', type: 'area', zoomType: 'xy' },
      title: { text: _chartTitle },
      xAxis: { type: 'datetime', minTickInterval: (24 * 3600 * 1000 ), maxZoom: (7 * 24 * 3600000),
        title: { text: null },
        dateTimeLabelFormats: {
           day: '%m/%d/%y',
           week: '%d-%b-%y',
           month: '%b-%Y',
           year: '%Y'
       } },
      yAxis: { title: { text: 'Points' } },
      legend: {
        layout: 'horizontal',
        backgroundColor: '#327aaf',
        shadow: true
      },
      tooltip: { shared: true, valueSuffix: ' points' },
      plotOptions: {
        area: {
          stacking: 'normal',
          lineWidth: 1,
        },
        series: {
          events: {
            legendItemClick: function(event) {
              if (this.name == 'done') return false;
            }
          }
        }
      },
      series: _dataSeries
    });

    // Hide icebox. Bug in tool forces us to perform this hack rather than set property in series.
    //  In a stacked graph, if the first item is invisible on render, chart doesn't show.
    chart.series[0].setVisible(false);
  });
});

//]]>  
