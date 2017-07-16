document.addEventListener('DOMContentLoaded', function(event) {

  Vue.component('modal', {
    template: '#modal-template',
    props: ['show'],
    });

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
        this.filterTheShifts()
      }.bind(this));
    },

    methods: {

      goAway: function() {
        this.showModal = false
      },

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