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
              drawBarGraph2(data);
              // drawBarGraph(data);
              drawBubblePlot(data);
              drawPieChart(data);
            },
            error: function(result) {
              error();
            }
    });
}

// ###########################################################################################
// ############################## ORIGINAL BAR GRAPH #########################################
// ###########################################################################################

function drawBarGraph2(barData) {

  var monthData = [];
  var months = [];
  var range = [0]
  var margin = {top: 0, right: 0, bottom: 30, left: 21}
  var height = 400 - margin.top - margin.bottom,
      width = 600 - margin.left - margin.right;

  for (var i = 0; i < barData.shifts[0].months.length; i++) {

   monthData.push(barData.shifts[0].months[i].total_month_shifts);
   months.push(barData.shifts[0].months[i].month);

  }


 var height = 400,
       width = 600,
       monthColor;

   var yScale = d3.scaleLinear()
       .domain([0, d3.max(monthData)])
       .range([0, height]);

   var yAxisValues = d3.scaleLinear()
     .domain([0, d3.max(monthData)])
     .range([height, 0]);

   var yAxisTicks = d3.axisLeft(yAxisValues)
     .ticks(8)

   // var xScale = d3.scaleBand()
   //     .domain(monthData)
   //     .paddingInner(.1)
   //     .paddingOuter(.1)
   //     .range([0, width])



   var xAxisValues = d3.scaleBand()
     .domain(months)
     .paddingInner(.1)
     .paddingOuter(.1)
     .range([0, width])


   var xAxisTicks = d3.axisBottom(xAxisValues)
     .ticks(months.length)





  var colors = d3.scaleLinear()
      .domain([0, d3.max(monthData) ])
      .range(['#2D8BCF', '#2CA02C'])

  var tooltip = d3.select('body')
                  .append('div')
                  .style('position', 'absolute')
                  .style('box-shadow', '0 0 5px #999')
                  .style('padding', '0 10px')
                  .style('background', 'white')
                  .style('text-align', 'center')
                  .style('margin-top', -10)
                  .style('opacity', 0)
                  .style('pointer-events', 'none');


  var myChart =
  d3.select('#viz').append('svg')
    .attr('width', width + margin.left + margin.right)
    .attr('height', height + margin.top + margin.bottom)
    .append('g')
      .attr('transform', 'translate(' + margin.left + ',' + margin.right + ')')
      .selectAll('rect').data(monthData)
        .enter().append('rect')
          .attr('fill', colors)
          .attr('width', (width / monthData.length) - 2)
          .attr('height', 0)
          .attr('x', function(d, i) {
            return ((width/ monthData.length) * i);
          })
          .attr('y', height)

      .on('mouseover', function(d) {
        tooltip.transition().duration(100)
          .style('opacity', .9)

          monthColor = this.style.fill;
          d3.select(this)
            .style('fill', 'yellow')
      })

      .on('mousemove', function(d) {
          tooltip.html(
              '<div style="font-size: 2rem; font-weight: bold">' + d + " shifts</div>"
            )
            .style('left', (d3.event.pageX -35) + 'px')
            .style('top', (d3.event.pageY -30) + 'px')


      })

      .on('mouseout', function(d) {

        tooltip.transition().duration(200)
          .style('opacity', 0)

        d3.select(this)
          .style('fill', monthColor)
      });



  var yGuide = d3.select('#viz svg').append('g')
                  .attr('transform', 'translate(20,0)')
                  .call(yAxisTicks)

  var xGuide = d3.select('#viz svg').append('g')
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


function drawBarGraph(barData) {

  var monthData = [];
  var months = [];
  var range = [0]
  var margin = {top: 0, right: 0, bottom: 30, left: 20}
  var height = 400 - margin.top - margin.bottom,
      width = 600 - margin.left - margin.right;

  for (var i = 0; i < barData.shifts[0].months.length; i++) {

   monthData.push(barData.shifts[0].months[i].total_month_shifts);
   months.push(barData.shifts[0].months[i].month);

  }


 var height = 400,
       width = 600,
       monthColor;

   var yScale = d3.scaleLinear()
       .domain([0, d3.max(monthData)])
       .range([0, height]);

   var yAxisValues = d3.scaleLinear()
     .domain([0, d3.max(monthData)])
     .range([height, 0]);

   var yAxisTicks = d3.axisLeft(yAxisValues)
     .ticks(8)

   var xScale = d3.scaleBand()
       .domain(monthData)
       .paddingInner(.1)
       .paddingOuter(.1)
       .range([0, width])



   var xAxisValues = d3.scaleBand()
     .domain(months)
     .paddingInner(.1)
     .paddingOuter(.1)
     .range([0, width])


   var xAxisTicks = d3.axisBottom(xAxisValues)
     .ticks(months.length)




  var colors = d3.scaleLinear()
      .domain([0, d3.max(monthData) ])
      .range(['#2D8BCF', '#2CA02C'])

  var tooltip = d3.select('body')
                  .append('div')
                  .style('position', 'absolute')
                  .style('box-shadow', '0 0 5px #999')
                  .style('padding', '0 10px')
                  .style('background', 'white')
                  .style('text-align', 'center')
                  .style('margin-top', -10)
                  .style('opacity', 0)
                  .style('pointer-events', 'none');


  var myChart =
  d3.select('#viz').append('svg')
    .attr('width', width + margin.left + margin.right)
    .attr('height', height + margin.top + margin.bottom)
    .append('g')
      .attr('transform', 'translate(' + margin.left + ',' + margin.right + ')')
      .selectAll('rect').data(monthData)
        .enter().append('rect')
          .attr('fill', colors)
          .attr('width', function(d) {
            return xScale.bandwidth();
          })
          .attr('height', 0)
          .attr('x', function(d) {
            return xScale(d);
          })
          .attr('y', height)

      .on('mouseover', function(d) {
        tooltip.transition().duration(100)
          .style('opacity', .9)

          monthColor = this.style.fill;
          d3.select(this)
            .style('fill', 'yellow')
      })

      .on('mousemove', function(d) {
          tooltip.html(
              '<div style="font-size: 2rem; font-weight: bold">' + d + " shifts</div>"
            )
            .style('left', (d3.event.pageX -35) + 'px')
            .style('top', (d3.event.pageY -30) + 'px')


      })

      .on('mouseout', function(d) {

        tooltip.transition().duration(200)
          .style('opacity', 0)

        d3.select(this)
          .style('fill', monthColor)
      });



  var yGuide = d3.select('#viz svg').append('g')
                  .attr('transform', 'translate(20,0)')
                  .call(yAxisTicks)

  var xGuide = d3.select('#viz svg').append('g')
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


function drawPieChart(pie_data) {
  'use strict';

  var position_data = []

  for (var i = 0; i < pie_data.positions.length; i++) {
    var object = {name: pie_data.positions[i].name, numEmployed: pie_data.positions[i].employed, enabled: true };
    position_data.push(object);
  }

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
    .style('margin', '0 auto')
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
    })
    .each(function(d) { this._current = d; })


    path.on('mouseover', function(d) {
      var total = d3.sum(position_data.map(function(d) {
        return (d.enabled) ? d.numEmployed : 0;
      }));

      var percent = Math.round(1000 * d.data.numEmployed / total) / 10;
      tooltip.select('.pieLabel').html(d.data.name);
      tooltip.select('.count').html("Number: " + d.data.numEmployed);
      tooltip.select('.percent').html(percent + '%')
      tooltip.style('display', 'block')

    })

    path.on('mouseout', function(d) {
      tooltip.style('display', 'none')
    })

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
    .style('cursor', 'pointer')
    .style('stroke-width', "2")
    .on('click', function(name) {
      var rect = d3.select(this),
          enabled = true;

      var  totalEnabled = d3.sum(position_data.map(function(d) {
        return d.enabled ? 1 : 0;
      }));

      if (rect.attr('class') === 'disabled') {
        rect.attr('class', '');
        rect.style('fill', colors)
      } else {
        if (totalEnabled < 2) return;
        rect.attr('class', 'disabled')
        enabled = false;
        rect.style('fill', 'transparent')
      };

      pie.value(function(d) {
        if (d.name === name) d.enabled = enabled;
        return (d.enabled) ? d.numEmployed : 0;
      });


      path = path.data(pie(position_data));

      path.transition()
        .duration(750)
        .attrTween('d', function(d) {
          var interpolate = d3.interpolate(this._current, d);
          this._current = interpolate(0)
          return function(t) {
            return arc(interpolate(t));
          };
        });



    })

  legend.append('text')
    .attr('x', legendRectSize + legendSpacing)
    .attr('y', legendRectSize - legendSpacing)
    .style('font-size', '12px')
    .text(function(d) { return d; });


  // TOOL TIP SETTINGS:

  var tooltip = d3.select('#chart')
    .append('div')
    .attr('id', 'pieTip')
    .style('background', '#eee')
    .style('box-shadow', '0 0 5px #999')
    .style('border', '1px solid #aaa')
    .style('color', 'black')
    .style('display', 'none')
    .style('font-size', '12px')
    .style('left', '370px')
    .style('padding', '10px')
    .style('position', 'absolute')
    .style('text-align', 'center')
    .style('top', '95px')
    .style('width', '100px')
    .style('z-index', '10');

  tooltip.append('div')
    .attr('class', 'pieLabel');

  tooltip.append('div')
    .attr('class', 'count');

  tooltip.append('div')
    .attr('class', 'percent');
}

function drawBubblePlot(bubble_data) {

  var employee_data = []
  var employeeColor;

  var maxValue = bubble_data.employees[0].average_shifts_per_month
  var minValue = bubble_data.employees[0].average_shifts_per_month

  for (var i = 0; i < bubble_data.employees.length; i++) {

    var initials = bubble_data.employees[i].name.split(' ')


    var object = {
                  name: bubble_data.employees[i].name,
                  position: bubble_data.employees[i].position,
                  average_per_month: bubble_data.employees[i].average_shifts_per_month,
                  initials: initials[0][0] + "." + initials[1][0] + '.',
                  selected: true


      }
      if (object.average_per_month > maxValue) {
        maxValue = object.average_per_month
      }

      if (object.average_per_month < minValue) {
        minValue = object.average_per_month
      }
      if (object.average_per_month > 0) {
        employee_data.push(object);

      }
  }


  // ---------###############--------------
  // Start making the circles
  var width = 1000,
      height = 500;

  var svg = d3.select('#bubble_chart')
    .append('svg')
      .attr('height', height)
      .attr('width', width)
      .append('g')
        .attr('transform', 'translate(0,0)')

  var colors = d3.scaleOrdinal(d3.schemeCategory20)

  tooltip = d3.select('body')
    .append('div')
      .style('position', 'absolute')
      .style('box-shadow', '0 0 5px #999')
      .style('padding', '0 10px')
      .style('background', 'white')
      .style('text-align', 'center')
      .style('margin-top', -10)
      .style('opacity', 0)
      .style('pointer-events', 'none');


  var radiusScale = d3.scaleSqrt()
    .domain([minValue, maxValue])
    .range([15, 60])

  // the simulation is a collection of forces about where
  // we want our circles to go and how we want them to interact
  // with each other.
  // STEP 1: move items to the middle
  // STEP 2: get them off each other.



  var goAway = d3.forceX(function(d) {
    if (d.selected === true) {
      return width / 2
    } else {
      return 2000
    }
  })


  var simulation = d3.forceSimulation()
    .force('x', d3.forceX(width / 2).strength(0.05))
    .force('y', d3.forceY(height / 2).strength(0.15))
    .force('collide', d3.forceCollide(function(d) {
      return radiusScale(d.average_per_month) + 1
    }))

  var circles = svg.selectAll('.employees')
    .data(employee_data)
    .enter()
    .append('circle')
      .attr('class', 'employees')
      .attr('r', function(d) {
        return radiusScale(d.average_per_month)
      })
      .attr('fill', function(d) {
        return colors(d.position)
      })
      .on('mouseenter', function(d) {

        tooltip.transition().duration(200)
          .style('opacity', .9)

          employeeColor = this.style.fill

          d3.select(this)
            .style('fill', 'blue')



      })
      .on('mousemove', function(d){
        tooltip.html(
          '<div style="font-weight: bold; font-size: 1.5rem;">' + d.name + ': ' + d.position + '</div><div style="font-size: 1.5rem;">' + d.average_per_month + ' shifts per month </div>'
          )
          .style('left', (d3.event.pageX - 100) + 'px')
          .style('top', (d3.event.pageY - 52) + 'px')
          .style('border')
      })
      .on('mouseout', function(d) {
        tooltip.transition().duration(200)
          .style('opacity', 0);

        d3.select(this)
          .style('fill', employeeColor)

        tooltip.html('')
      })

  //add names to the circles
  var labels = svg.selectAll('circles')
    .data(employee_data)
    .enter()
    .append('text')
      .attr('class', 'employee-label')
      .attr('text-anchor', 'middle')
      .attr('fill', 'black')
      .attr('font-size', '12px')
      .style('font-weight', 'bold')
      .style('pointer-events', 'none')
      .text(function(d) {
        return d.initials;
      })


  simulation.nodes(employee_data)
    .on('tick', ticked)

  function ticked() {
    circles
      .attr('cx', function(d) {
        return d.x
      })
      .attr('cy', function(d){
        return d.y
      })
    labels
      .attr('x', function(d) {
        return d.x;
      })
      .attr('y', function(d){
        return d.y + 5;
      })
  }

  var  legendRectSize = 18,
       legendSpacing = 4;

  var legend = svg.selectAll('.legend')
    .data(colors.domain())
    .enter()
    .append('g')
      .style('cursor', 'pointer')
      .attr('class', 'legend')
      .attr('transform', function(d, i) {
        var height = i * 25 + legendSpacing
        var width = legendRectSize + 5
        return 'translate(' + width + ',' + height + ')'
      });



  legend.append('rect')
    .attr('width', legendRectSize)
    .attr('height', legendRectSize)
    .style('fill', colors)
    .style('stroke', colors)
    .style('stroke-width', "2")
    .on('click', function(d) {
      var item = d3.select(this)
          selected = true;

      function flyAway() {
        simulation
          .force('x', goAway.strength(0.03))
          .force('collide', d3.forceCollide(function(d) {
                return (radiusScale(d.average_per_month) + 1 )
              }).iterations(20))
          .alphaTarget(0.5)
          .restart()
      }


      if (item.attr('class') === 'disabled'){
        item.attr('class', '')
        item.style('fill', colors)

        for(var i = 0; i < employee_data.length; i++) {
          if(employee_data[i].position === d) {
            employee_data[i].selected = true;
          }
        }

        flyAway();
      } else {

        for(var i = 0; i < employee_data.length; i++) {
          if(employee_data[i].position === d) {
            employee_data[i].selected = false;
          }
        }

        item.attr('class', 'disabled')
        item.style('fill', 'transparent')



        flyAway();
      }


    });

  legend.append('text')
    .attr('x', legendRectSize + legendSpacing)
    .attr('y', legendRectSize - legendSpacing)
    .style('font-size', '12px')
    .text(function(d) { return d; });
}






});
