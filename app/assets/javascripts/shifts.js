document.addEventListener('DOMContentLoaded', function(event) {

  var app = new Vue({
    el: '#shifts',

    data: {
            message: "Hello World!",
            shift: [],
            positions: [],
            scheduledPositions: [],

            employees: [],
            scheduledEmployees: [],
            segment: ''
          },

    methods: {
      initialPositions: function(fullList) {
        console.log(this.segment)
        $.get('/api/v1/shifts/' + this.segment + '.json', function(fullList) {
          // console.log(fullList.shifts);
          this.shift = fullList;
        }.bind(this));
      }
      // initialEmployees: function() {

      // }

      // addPosition:,
      // deletePosition:,
      // scheduleEmployee:,
      // unassignEmployee:,

      // assignedPositions:,
      // assignedEmployees:

    },

    mounted: function() {
      this.segment = $(location).attr('href').split('/').splice(4,1).join()

      this.initialPositions();
      // this.assignedEmployees;
    },

    compute: function() {}
  });
});