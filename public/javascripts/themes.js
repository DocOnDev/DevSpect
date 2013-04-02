/**
 * Gray theme for Highcharts JS
 * @author Torstein Hønsi
 */

$(document).ready(function() {
   /*
   colors: ["#0072bc", "#379cde", "#23638d", "#004a7a", "#64eade", "#99333e", "#252b95", "#3941e3", "#000681","#61a179", "#666ce3"],
   colors: ["#DDDF0D", "#7798BF", "#55BF3B", "#DF5353", "#aaeeee", "#ff0066", "#eeaaee", "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"], 
   colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
   colors: ["#514F78", "#42A07B", "#9B5E4A", "#72727F", "#1F949A", "#82914E", "#86777F", "#42A07B"],
    */
  var defaultColors = ["#ccccff", "#ff7538", "#ffd700", "#0087bd", "#009f6b", "#c40233", "#5588AA", "#252b95", "#3941e3", "#000681","#61a179", "#666ce3"]
  _chartColors = (typeof chartColors != 'undefined' ? chartColors : defaultColors);

  Highcharts.theme = {
     colors: _chartColors,
     chart: {
        backgroundColor: {
           linearGradient: [0, 0, 400, 400],
           stops: [
              [0, 'rgb(255, 255, 255)'],
              [1, 'rgb(230, 230, 255)']
           ]
        },
        borderWidth: 0,
        borderRadius: 15,
        plotBackgroundColor: null,
        plotShadow: false,
        plotBorderWidth: 0
     },
     title: {
        style: {
           color: '#333',
           font: '16px Lucida Grande, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
        }
     },
     subtitle: {
        style: {
           color: '#666',
           font: '12px Lucida Grande, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
        }
     },
     xAxis: {
        gridLineWidth: 0,
        lineColor: '#333',
        tickColor: '#333',
        labels: {
           style: {
              color: '#666',
              fontWeight: 'bold'
           }
        },
        title: {
           style: {
              color: '#AAA',
              font: 'bold 12px Lucida Grande, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
           }
        }
     },
     yAxis: {
        alternateGridColor: null,
        minorTickInterval: null,
        gridLineColor: 'rgba(155, 155, 155, .1)',
        lineWidth: 0,
        tickWidth: 0,
        labels: {
           style: {
              color: '#666',
              fontWeight: 'bold'
           }
        },
        title: {
           style: {
              color: '#AAA',
              font: 'bold 12px Lucida Grande, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
           }
        }
     },
     legend: {
        itemStyle: {
           color: '#CCC'
        },
        itemHoverStyle: {
           color: '#FFF'
        },
        itemHiddenStyle: {
           color: '#333'
        }
     },
     labels: {
        style: {
           color: '#CCC'
        }
     },
     tooltip: {
        backgroundColor: {
           linearGradient: [0, 0, 0, 50],
           stops: [
              [0, 'rgba(96, 96, 96, .8)'],
              [1, 'rgba(16, 16, 16, .8)']
           ]
        },
        borderWidth: 0,
        style: {
           color: '#FFF'
        }
     },


     plotOptions: {
        line: {
           dataLabels: {
              color: '#CCC'
           },
           marker: {
              lineColor: '#333'
           }
        },
        spline: {
           marker: {
              lineColor: '#333'
           }
        },
        scatter: {
           marker: {
              lineColor: '#333'
           }
        },
        candlestick: {
           lineColor: 'white'
        }
     },

     toolbar: {
        itemStyle: {
           color: '#CCC'
        }
     },

     navigation: {
        buttonOptions: {
           backgroundColor: {
              linearGradient: [0, 0, 0, 20],
              stops: [
                 [0.4, '#606060'],
                 [0.6, '#333333']
              ]
           },
           borderColor: '#000000',
           symbolStroke: '#C0C0C0',
           hoverSymbolStroke: '#FFFFFF'
        }
     },

     exporting: {
        buttons: {
           exportButton: {
              symbolFill: '#55BE3B'
           },
           printButton: {
              symbolFill: '#7797BE'
           }
        }
     },

     // scroll charts
     rangeSelector: {
        buttonTheme: {
           fill: {
              linearGradient: [0, 0, 0, 20],
              stops: [
                 [0.4, '#888'],
                 [0.6, '#555']
              ]
           },
           stroke: '#000000',
           style: {
              color: '#CCC',
              fontWeight: 'bold'
           },
           states: {
              hover: {
                 fill: {
                    linearGradient: [0, 0, 0, 20],
                    stops: [
                       [0.4, '#BBB'],
                       [0.6, '#888']
                    ]
                 },
                 stroke: '#000000',
                 style: {
                    color: 'white'
                 }
              },
              select: {
                 fill: {
                    linearGradient: [0, 0, 0, 20],
                    stops: [
                       [0.1, '#000'],
                       [0.3, '#333']
                    ]
                 },
                 stroke: '#000000',
                 style: {
                    color: 'yellow'
                 }
              }
           }
        },
        inputStyle: {
           backgroundColor: '#333',
           color: 'silver'
        },
        labelStyle: {
           color: 'silver'
        }
     },

     navigator: {
        handles: {
           backgroundColor: '#666',
           borderColor: '#AAA'
        },
        outlineColor: '#CCC',
        maskFill: 'rgba(16, 16, 16, 0.5)',
        series: {
           color: '#7798BF',
           lineColor: '#A6C7ED'
        }
     },

     scrollbar: {
        barBackgroundColor: {
              linearGradient: [0, 0, 0, 20],
              stops: [
                 [0.4, '#888'],
                 [0.6, '#555']
              ]
           },
        barBorderColor: '#CCC',
        buttonArrowColor: '#CCC',
        buttonBackgroundColor: {
              linearGradient: [0, 0, 0, 20],
              stops: [
                 [0.4, '#888'],
                 [0.6, '#555']
              ]
           },
        buttonBorderColor: '#CCC',
        rifleColor: '#FFF',
        trackBackgroundColor: {
           linearGradient: [0, 0, 0, 10],
           stops: [
              [0, '#000'],
              [1, '#333']
           ]
        },
        trackBorderColor: '#666'
     },

     // special colors for some of the demo examples
     legendBackgroundColor: 'rgba(48, 48, 48, 0.8)',
     legendBackgroundColorSolid: 'rgb(70, 70, 70)',
     dataLabelsColor: '#444',
     textColor: '#E0E0E0',
     maskColor: 'rgba(255,255,255,0.3)'
  };

  // Apply the theme
  var highchartsOptions = Highcharts.setOptions(Highcharts.theme);
});
