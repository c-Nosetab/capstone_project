$.ajaxSetup({
    headers: {
        'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
 }
});



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
              totalQuantity: '',
              test: 0,
              shiftPosition: '',


              // Info for adding employee to Shift:!!!!
              newAssignEmployeeId: 0,
              assignEmployee: {},
              indexOfEmployee: 0,

              newPositionIndex: 0,
              positionQuantity: 1,

              assignPositionId: 0,
              assignPosition: {},

              numbe: 0,



              newPositionId: 0,

              segment: '',
              quantityCount: []
            },

      methods: {


        initialPositions: function(fullList) {
          $.get('/api/v1/shifts/' + this.segment + '.json', function(fullList) {
            this.shift = fullList;
          }.bind(this));
        },

        assignNewEmployee: function(position_name, position_index) {

          this.newAssignEmployeeId = this.$refs[position_name][0].value;
          this.assignPosition = this.shift.positions[position_index];
          this.newPositionIndex = position_index;

          for(var i = 0; i < this.shift.positions[position_index].unassigned_employees.length; i++) {
            if (this.shift.positions[position_index].unassigned_employees[i].id === parseInt(this.newAssignEmployeeId)) {
              this.assignEmployee = this.shift.positions[position_index].unassigned_employees[i];
            };
          };


          if (this.assignEmployee.full_name) {
            var databaseParams = {
                                  employeeId: this.assignEmployee.id,
                                  shiftId: this.shift.id,
                                  companyId: this.shift.company_id
                                  }

            $.post('/api/v1/employee_shifts.json', databaseParams, function() {
              this.shift.positions[this.newPositionIndex].assigned_employees.push(this.assignEmployee);
              this.shift.positions[this.newPositionIndex].unassigned_employees.splice(this.indexOfEmployee, 1);
              this.assignEmployee = {}

            }.bind(this)).fail( function(response) {
              this.errors = ["Something Went Wrong"]
            }.bind(this));

          };
        },

        unassignEmployee: function(employee, pos_index, emp_index) {
          this.errors = []
          var params = {
                        employeeId: employee.id,
                        shiftId: this.shift.id
                      };

          this.shift.positions[pos_index].assigned_employees.splice(emp_index, 1)
          this.shift.positions[pos_index].unassigned_employees.push(employee)

          $.ajax({
                  type: 'DELETE',
                  url: '/api/v1/employee_shifts.json',
                  data: params,
                  Accept: 'application/json',
                  success: function(result) {
                    this.errors = ["Successfully Removed"]
                  },

                  error: function(error) {
                    console.log(error)
                  }
          });
        },

        changeQuantity: function(event) {
          this.test = event.target.value
          this.assignPositionId = parseInt(event.target.value)
          this.totalQuantity = this.shift.positions[event.target.value - 1].unassigned_employees.length;
        },

        scheduleNewPosition: function() {
          if(this.positionQuantity > 0 && this.assignPositionId !== 0) {
            for(var i = 0; i < this.shift.positions.length; i++) {
              if (this.shift.positions[i].id === this.assignPositionId) {
                  var positionIndex = i
                  var positionBeingAssigned = this.shift.positions[i];
              };
            };
                  var params = {
                                shiftId: this.shift.id,
                                positionId: this.assignPositionId,
                                quantity: parseInt(this.positionQuantity),
                                companyId: this.shift.company_id
                                };

                  $.post('/api/v1/position_shifts.json', params, function() {

                    this.shift.positions[positionIndex].quantity = this.positionQuantity;
                    this.positionQuantity = '';
                    this.totalQuantity = 0;



                  }.bind(this)).fail( function(response) {
                    this.errors = "Something Went Wrong";
                  }.bind(this));
                }
        },

        deletePosition: function(pos_index) {
          this.shift.positions[pos_index].quantity = 0;

          for(var i = this.shift.positions[pos_index].assigned_employees.length - 1; i > -1; i--) {
            var employee = this.shift.positions[pos_index].assigned_employees[i]

            var emp_params = {
                          employeeId: this.shift.positions[pos_index].assigned_employees[i].id,
                          shiftId: this.shift.id
                        }

                this.shift.positions[pos_index].assigned_employees.splice(i, 1)
                this.shift.positions[pos_index].unassigned_employees.push(employee)

            $.ajax({
                    type: 'DELETE',
                    url: '/api/v1/employee_shifts.json',
                    data: emp_params,
                    Accept: 'application/json',
                    success: function(result) {
                      this.errors = ["Successfully Removed"]
                    },
                    error: function(error) {
                      console.log(error)
                    }
            });
          };



          var pos_params = {
                        shiftId: this.shift.id,
                        positionId: this.shift.positions[pos_index].id
                        };


          $.ajax({
                  type: 'DELETE',
                  url: '/api/v1/position_shifts.json',
                  data: pos_params,
                  Accept: 'application/json',
                  success: function(result) {
                    this.errors = ["Successfully Removed"];
                  },

                  error: function(error) {
                    console.log(error)
                  }
          });

        },



      },

      mounted: function() {
        var test = $(location).attr('href').split('/').splice(3,2)
          if(test[0] == "shifts" && test.length === 2) {
            this.segment = test[1]
            this.initialPositions();

          }


      },
    });



});