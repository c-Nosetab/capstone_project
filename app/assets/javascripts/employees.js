document.addEventListener("DOMContentLoaded", function(event) {


      doTheVue();
function doTheVue() {
  var app = new Vue({
    el: "#employees",

    data: {
            message: "Hello World",
            employees: [],

            newFirstName: '',
            newLastName: '',
            newEmail: '',
            admin: false,
            manager: false,
            newPositionId: 0,
    },

    mounted: function() {
          this.getInfo()

    },

    methods: {

      getInfo: function() {
        $.get('/api/v1/employees.json', function(employees) {
          this.employees = employees;
        }.bind(this));
      },

      addEmployee: function() {
        var params = {
                      full_name: this.newFirstName + " " + this.newLastName,
                      email: this.newEmail,
                      position_id: this.newPositionId
                      };

        console.log(params)

        this.employees.push(params)
      }

    }

  });



}
});