


// LEFT OFF HERE =
// http://zeroviscosity.com/d3-js-step-by-step/step-5-adding-tooltips




document.addEventListener('DOMContentLoaded', function(event) {

var test = $(location).attr('href').split('/').splice(4,2)
    if (test[1] == 'data') {
      var companyId = test[0];
       findData(companyId);
    }



function findData(id) {
    $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: "/api/v1/data/" + id,
            dataType: 'json',
            success: function(data) {
              drawBarGraph(data);
              // drawBubblePlot(data);
              drawPieChart(data);
            },
            error: function(result) {
              error();
            }
    });
}

function drawBarGraph(barData) {
  var monthData = [],
      months = [],
      data_array = [],
      margin = {top: 0, right: 0, bottom: 30, left: 20 },
      height = 400,
      width = 600 ;

  var valueColor,
      yScale,
      yAxisValues,
      yAxisTicks,
      yGuide,
      xScale,
      xAxisValues,
      xAxisTicks,
      xGuide,
      colors,
      tooltip,
      monthChart;


  for (var i = 0; i < barData.shifts[0].months.length; i++) {

   // var object = {month: barData.shifts[0].months[i].month, shift_count: barData.shifts[0].months[i].total_month_shifts}

   // barData.push(object)
   // .push(Data.shifts[0].months[i].total_month_shifts)

   monthData.push(barData.shifts[0].months[i].total_month_shifts);
   months.push(barData.shifts[0].months[i].month);
  }

  console.log(monthData)




      yScale = d3.scaleLinear()
          .domain([0, d3.max(monthData)])
          .range([0,height]);

      yAxisValues = d3.scaleLinear()
        .domain([0, d3.max(monthData)])
        .range([height, 0]);

      yAxisTicks = d3.axisLeft(yAxisValues)
        .ticks(5)



      xScale = d3.scaleBand()
          .domain(monthData)
          .paddingInner(.1)
          .paddingOuter(.1)
          .range([0, width])

      xAxisValues = d3.scaleOrdinal()
        .domain([months[0], months[(months.length)]])
        .range([0, width])


      xAxisTicks = d3.axisBottom(xAxisValues)
        .ticks(2)

      colors = d3.scaleLinear()
          .domain([0, 7, d3.max(monthData)])
          .range(['#B58929', '#C61C6F', '#85992C'])

      tooltip = d3.select('body')
                      .append('div')
                      .style('position', 'absolute')
                      .style('padding', '0 10px')
                      .style('background', 'white')
                      .style('opacity', 0);

      myChart =
      d3.select('#viz').append('svg')
        .attr('width', width + margin.left + margin.right)
        .attr('height', height + margin.top + margin.bottom)
        .append('g')
        .attr('transform',
                'translate(' + margin.left + ',' + margin.right + ')')
      .selectAll('rect').data(monthData)
        .enter().append('rect')
          .attr('fill',  colors)
          .attr('width', function(d) {return xScale.bandwidth()})

          .attr('height', 0)
          .attr('x', function(d) {return xScale(d)})
          .attr('y', height)

          .on('mouseover', function(d) {

            tooltip.transition().duration(200)
              .style('opacity', .9)

            tooltip.html(
              '<div style="font-size: 2rem; font-weight: bold">' + d + ' Shifts </div>'
              )
              .style('left', (d3.event.pageX -35) + 'px')
              .style('top', (d3.event.pageY -30) + 'px')

            tempColor = this.style.fill;
            d3.select(this)
              .style('fill', 'yellow')
          })

          .on('mouseout', function(d) {

            tooltip.html('')

            d3.select(this)
              .style('fill', tempColor)
          });


      yGuide = d3.select('#viz svg').append('g')
                 .attr('transform', 'translate(20, 0)')
                 .call(yAxisTicks)

      xGuide = d3.select('#viz svg').append('g')
                 .attr('transform', 'translate(20,' + height + ')')
                 .call(xAxisTicks)


      myChart.transition()
        .attr('height', function(d) {
          return yScale(d);
        })
        .attr('y', function(d) {
          return height - yScale(d);
        })
        .delay(function(d, i) {
          return i * 20;
        })
        .duration(1000)
        .ease(d3.easeBounceOut)
}


function drawBubblePlot(bubble_data) {



  var employees = []

  for (var i = 0; i < data.employees.length; i++) {
    var object = {name: data.employees[i].name, average: parseInt(data.employees[i].average_shifts_per_month)};
    employees.push(object);
  }


  console.log(employees[0].name)


  var diameter = 600;

  var svg = d3.select('#bubble_plot').append('svg')
          .attr('width', diameter)
          .attr('height', diameter)
          .style('background', 'white');

  var bubble = d3.layout.pack()
        .size([diameter, diameter])
        .value(function(d) {return d.size;})
        .padding(3);
}


function drawPieChart(pie_data) {
  'use strict';

  var position_data = []

  for (var i = 0; i < pie_data.positions.length; i++) {
    var object = {name: pie_data.positions[i].name, numEmployed: pie_data.positions[i].employed };
    position_data.push(object);
  }

  console.log(position_data)

  var dataset = [
                  {label: "Abulia", count: 10},
                  {label: "Betelgeuse", count: 20},
                  {label: "Cantaloupe", count: 30},
                  {label: "Dijkstra", count: 40}
                ];

  var width = 360,
      height =360,
      radius = Math.min(width, height) / 2,
      donutWidth = 75,
      legendRectSize = 18,
      legendSpacing = 4;

  var colors = d3.scaleOrdinal(d3.schemeCategory20b)

  var svg = d3.select('#chart')
    .append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
      .attr('transform', 'translate(' + (width / 2) +  ',' + (height / 2) + ')');


   var arc = d3.arc()
     .innerRadius(radius - donutWidth)
     .outerRadius(radius);

  var pie = d3.pie()
    .value(function(d) { return d.numEmployed; })
    .sort(null);

  var path = svg.selectAll('path')
    .data(pie(position_data))
    .enter()
    .append('path')
    .attr('d', arc)
    .attr('fill', function(d, i) {
      return colors(d.data.name);
    });


  // LEDGEND SETUP:

  var legend = svg.selectAll('.legend')
    .data(colors.domain())
    .enter()
    .append('g')
      .attr('class', 'legend')
      .attr('transform', function(d, i) {
        var height = legendRectSize + legendSpacing,
            offset = height * colors.domain().length / 2,
            horz = -2 * legendRectSize,
            vert = i * height - offset;
        return 'translate(' + horz + ',' + vert + ')';
      });

  legend.append('rect')
    .attr('width', legendRectSize)
    .attr('height', legendRectSize)
    .style('fill', colors)
    .style('stroke', colors)
    .style('stroke-width', "2");

  legend.append('text')
    .attr('x', legendRectSize + legendSpacing)
    .attr('y', legendRectSize - legendSpacing)
    .style('font-size', '12px')
    .text(function(d) { return d; });

}






});



// (function() {

//   // Fake JSON data
//   var json = {"countries_msg_vol": {
//     "CA": 170, "US": 393, "BB": 12, "CU": 9, "BR": 89, "MX": 192, "PY": 32, "UY": 9, "VE": 25, "BG": 42, "CZ": 12, "HU": 7, "RU": 184, "FI": 42, "GB": 162, "IT": 87, "ES": 65, "FR": 42, "DE": 102, "NL": 12, "CN": 92, "JP": 65, "KR": 87, "TW": 9, "IN": 98, "SG": 32, "ID": 4, "MY": 7, "VN": 8, "AU": 129, "NZ": 65, "GU": 11, "EG": 18, "LY": 4, "ZA": 76, "A1": 2, "Other": 254
//   }};

//   // D3 Bubble Chart



//   // generate data with calculated layout values
//   // var nodes = bubble.nodes(processData(json))
//   //           .filter(function(d) { return !d.children; }); // filter out the outer bubble

//   // var vis = svg.selectAll('circle')
//   //         .data(nodes);

//   // vis.enter().append('circle')
//   //     .attr('transform', function(d) { return 'translate(' + d.x + ',' + d.y + ')'; })
//   //     .attr('r', function(d) { return d.r; })
//   //     .attr('class', function(d) { return d.className; });

//   // function processData(data) {
//     var obj = json.countries_msg_vol;

//     var newDataSet = [];

//     for(var prop in obj) {
//       newDataSet.push({name: prop, className: prop.toLowerCase(), size: obj[prop]});
//     }
//     console.log(newDataSet)
//   // },












// })();