document.addEventListener('DOMContentLoaded', function(event) {

  var app = new Vue({
    el: '#shifts',

    data: {
            form: {
                    form_id: []
            },

            shift: [],
            errors: [],
            newPosition: {
                                    quantity: 0,
                                    position_id: 0,
                                    shift_id: this.segment
                                    },

            scheduledEmployees: [],
            assignEmployeeArray: [],


            // Info for adding employee to Shift:!!!!
            newAssignEmployeeId: 0,
            assignEmployee: {},
            indexOfEmployee: 0,

            newPositionIndex: 0,
            positionQuantity: 0,

            assignPositionId: 0,
            assignPosition: {},



            newPositionId: 0,

            segment: '',
            quantityCount: []
          },

    methods: {
      initialPositions: function(fullList) {
        $.get('/api/v1/shifts/' + this.segment + '.json', function(fullList) {
          // console.log(fullList.shifts);
          this.shift = fullList;
        }.bind(this));
      },

      changeSelected: function(position_index, event) {
        this.newAssignEmployeeId = event.target.value;
        this.assignPosition = this.shift.positions[position_index];
        this.newPositionIndex = position_index

        for(var i = 0; i < this.shift.positions[position_index].unassigned_employees.length; i++) {
          if (this.shift.positions[position_index].unassigned_employees[i].id === parseInt(this.newAssignEmployeeId)) {
            this.assignEmployee = this.shift.positions[position_index].unassigned_employees[i];
            this. indexOfEmployee = i
          };
        };
        console.log(this.shift.positions[position_index].unassigned_employees);
      },

      assignNewEmployee: function(position) {
        console.log(position);
        this.errors = [];

        if (this.assignEmployee.id != null && this.assignEmployee.position === position) {
          var databaseParams = {
                                employeeId: this.assignEmployee.id,
                                shiftId: this.shift.id,
                                companyId: this.shift.company_id
                                }

          $.post('/api/v1/employee_shifts.json', databaseParams, function() {
            console.log(databaseParams)
            this.shift.positions[this.newPositionIndex].assigned_employees.push(this.assignEmployee);
            this.shift.positions[this.newPositionIndex].unassigned_employees.splice(this.indexOfEmployee, 1);
            this.assignEmployee = {}
            console.log("Success!")
          }.bind(this)).fail( function(response) {
            this.errors = ["Something Went Wrong"]
          }.bind(this));

        };
      },

      unassignEmployee: function(employee) {
        this.errors = []
        var params = {
                      employeeId: employee.id,
                      shiftId: this.shift.id
                    };

        $.ajax({
                url: '/api/v1/employee_shifts.json',
                type: 'DELETE',
                dara: params,
                success: function(result) {
                  this.errors = ["Successfully Removed"]

                },

                error: function(error) {

                }
        })
      },

      scheduleNewPosition: function() {
        if(this.positionQuantity > 0 && this.assignPositionId !== 0) {

          for(var i = 0; i < this.shift.positions.length; i++) {
            if (!this.shift.positions[i].quantity && this.shift.positions[i].id === this.assignPositionId) {
                var positionIndex = i
                var positionBeingAssigned = this.shift.positions[i];
            };
          };


          var params = {
                        shiftId: this.shift.id,
                        positionId: this.assignPositionId,
                        quantity: parseInt(this.positionQuantity)
                        };

          $.post('/api/v1/position_shifts.json', params, function() {
            var vueParams = {quantity: parseInt(this.positionQuantity)};
            this.shift.positions[positionIndex].push(vueParams);


          }.bind(this)).fail( function(response) {
            this.errors = "Something Went Wrong";
          }.bind(this));
        }
      },


      // addPosition:,
      // deletePosition:,

    },

    mounted: function() {
      this.segment = $(location).attr('href').split('/').splice(4,1).join()

      this.initialPositions();



    },
  });
});