document.addEventListener('DOMContentLoaded', function(event) {

  var app = new Vue({
    el: '#shifts',

    data: {
            form: {
                    form_id: []
            },

            shift: [],
            things: [1, 2, 3],
            newPosition: {
                                    quantity: 0,
                                    position_id: 0,
                                    shift_id: this.segment
                                    },

            employees: [],
            scheduledEmployees: [],
            assignNewEmployee: '',
            assignEmployeeArray: [],

            newPositionId: 0,
            newPositionShiftId: 0,
            newPositionQuantity: 0,


            segment: '',
            quantityCount: []
          },

    methods: {
      initialPositions: function(fullList) {
        $.get('/api/v1/shifts/' + this.segment + '.json', function(fullList) {
          // console.log(fullList.shifts);
          this.shift = fullList;
          this.calculateQuantity();
        }.bind(this));

      },

      assignEmployee: function(employee) {
        console.log(employee)
      },

      scheduleNewPosition: function() {
        console.log(this.newPosition)
      },

      sayHello: function() {
        console.log("hello")
      },

      calculateQuantity: function() {
        var count = 0

        for (var i = 0; i < this.shift.positions.length - 1; i++) {
          if (this.shift.positions[i].quantity) {
            count += this.shift.positions[i].quantity;
          };
        };
        for (var i = 0; i < count; i++) {
          this.quantityCount.push(i);
        }
        console.log(this.quantityCount);
      }

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



    },
  });
});