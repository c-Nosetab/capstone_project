
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
              drawData(data);
            },
            error: function(result) {
              error();
            }
    });




}

function drawData(data) {
  var monthData = [],
      months = [],
      margin = {top: 0, right: 0, bottom: 30, left: 20 },
      height = 400 - margin.top - margin.bottom,
      width = 600 - margin.left - margin.right

  var   valueColor,
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


  for (var i = 0; i < data.shifts[0].months.length; i++) {
    monthData.push(data.shifts[0].months[i].total_month_shifts);
    months.push(data.shifts[0].months[i].month);
  }




  yScale = d3.scaleLinear()
      .domain([0, d3.max(monthData)])
      .range([0,height]);

  yAxisValues = d3.scaleLinear()
    .domain([0, d3.max(monthData)])
    .range([height, 0]);

  yAxisTicks = d3.axisLeft(yAxisValues)
    .ticks(10)



  xScale = d3.scaleBand()
      .domain(monthData)
      .paddingInner(.1)
      .paddingOuter(.1)
      .range([0, width])

  xAxisValues = d3.scaleOrdinal()
    .domain([months[0], months[(months.length - 1)]])
    .range([width, 0])


  xAxisTicks = d3.axisBottom(xAxisValues)
    .ticks(6)

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


});