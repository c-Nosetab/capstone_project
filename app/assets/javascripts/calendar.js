document.addEventListener('DOMContentLoaded', function(event) {


  Vue.component('modal', {
    template: '#modal-template'
  })



// MAIN CODE
  var cal = new Vue({
    el: '#calendar',

    data: {
            shifts: [],
            filteredShifts: [],
            showModal: false,

            days: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
            months: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],

            link: '',
            test: 'wow!',


            nowYear: 0,
            nowMonth: 0,
            nowDay: 0,


            currentYear: 0,
            currentMonth: 0,
            currentDay: 0,
            firstOfMonth: 0,
            monthWeeks: 0,
            lastOfMonth: 0,

            count: 0,

            popoverYear: 0,
            popoverMonth: 0,
            popoverDay: 0,







    },

    mounted: function() {
      var date = new Date;
      this.currentMonth = date.getMonth();
      this.nowMonth = this.currentMonth;

      this.currentYear = date.getFullYear();
      this.nowYear = this.currentYear;

      this.currentDay = date.getDate();
      this.nowDay = this.currentDay;

      this.firstOfMonth = new Date(date.getFullYear(), date.getMonth(), 1).getDay().toString();
      this.lastOfMonth = new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate().toString();
      this.monthWeeks = Math.ceil(this.lastOfMonth / 7);
      this.count = parseInt(8 - this.firstOfMonth);


      $.get('/api/v1/shifts.json', function(fullList) {
        // console.log(fullList.shifts);
        this.shifts = fullList;
        this.filterTheShifts();
        this.createPopover();
      }.bind(this));
    },

    methods: {

      createPopover: function() {
        // var year1 = this.popoverYear
        // var month1 = this.popoverMonth
        // var day1 = this.popoverDay

        $('[data-toggle="popover"]').popover({
            html: true,

            content: function(){
              var hours = ''
              var minutes = ''
              for(var i = 1; i < 13; i++) {
                hours += '<option value="' + i +'">'+ i +'</option>'
              }

              for(var i = 0; i < 60; i+= 5) {
                if (i < 10) {
                  minutes += '<option value="'+i+'">0' + i + '</option>'
                } else {
                  minutes += '<option>'+ i +'</option>'
                }
              }

              return '<div class="popover-body"><div class="start-time"><select>'+ hours +'</select> : <select>'+ minutes +'</select><select><option>AM</option><option>PM</option></select> <br></div><p style="color: black;">to</p> <div class="end-time"><select>'+ hours +'</select> : <select>'+ minutes +'</select><select><option>AM</option><option>PM</option></select></div><hr><div class="form-button"><button>Submit</button></div></div>'
            }

        })
      },

      // redrawPopover: function() {
      //   console.log('hi')
      //   $('popover').attr('data-content', 'hello');
      //   var popover = $('popover').data('popover');
      //   console.log(popover)
      //   popover.setContent();
      //   popover.$tip.addClass(popover.options.placement);
      // },

      // popoverContent: function(year, month, day) {
      //   this.popoverYear = year;
      //   this.popoverMonth = month;
      //   this.popoverDay = day;
      //   this.createPopover();

      //   $('.popover').popover({
      //     html: true,
      //     content: function() {
      //       return 'hi'
      //     }

      //   })

      // },

      test: function(year, month, day) {
        this.link = '/shifts/new?y=' + year + '&m=' + (month + 1) + '&d=' + day
        window.location = this.link;
      },

      filterTheShifts: function() {
        for(var i = 0; i < this.shifts.length; i++) {
          var currentShift = this.shifts[i].date.split('-')

          if (
              (new Date(currentShift[0], currentShift[1] - 1, currentShift[2])) > (new Date(this.currentYear, this.currentMonth, 0)) &&
              (new Date(currentShift[0], currentShift[1] - 1, currentShift[2])) <= (new Date(this.currentYear, this.currentMonth, this.lastOfMonth))) {
            this.filteredShifts.push(this.shifts[i])
          }
        }
      },

      findClass: function(date) {
        currentDate = new Date(this.nowYear, this.nowMonth, this.nowDay);

        if (date < currentDate) {
          return 'past'
        } else if (date > currentDate) {
        } else {
          return 'today'
        }
      },

      setValues: function() {
        this.firstOfMonth = new Date(this.currentYear, this.currentMonth, 1).getDay().toString();
        this.lastOfMonth = new Date(this.currentYear, this.currentMonth + 1, 0).getDate().toString();
        this.monthWeeks = Math.ceil(this.lastOfMonth / 7);
        this.count = parseInt(8 - this.firstOfMonth);
        this.filteredShifts = []
        this.filterTheShifts()
      },

      changeMonth: function(value) {
        if (this.currentMonth + value > 11) {
          this.currentYear += 1;
          this.currentMonth = 0;
        } else if (this.currentMonth + value < 0) {
          this.currentYear -= 1;
          this.currentMonth = 11;
        } else {
          this.currentMonth += value;
        }

        this.setValues()
      },



    }










  });
});