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

            startHours: '',
            endHours: '',
            minutes: '',
            company: 0,




            count: 0,

            popoverYear: new Date().getFullYear(),
            popoverMonth: new Date().getMonth(),
            popoverDay: new Date().getDate(),
            $popover: '',







    },

    mounted: function() {

      this.company = parseInt($(location).attr('href').split('/').splice(4, 1))

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
        this.getHoursAndMinutes();
      }.bind(this));
    },

    methods: {

      getHoursAndMinutes: function() {

        var startHours = '';
        var endHours = '';
        var minutes = '';

        for(var i = 1; i < 13; i++) {
          if (i === 8) {
            this.startHours += '<option selected>'+ i +'</option>'
          } else {
            this.startHours += '<option>'+ i +'</option>'
          }
        }

        for(var i = 1; i < 13; i++) {
          if (i === 4) {
            this.endHours += '<option selected>'+ i +'</option>'
          } else {
            this.endHours += '<option>'+ i +'</option>'
          }
        }


        for(var i = 0; i < 60; i+= 5) {
          if (i < 10) {
            this.minutes += '<option value="'+i+'">0' + i + '</option>'
          } else {
            this.minutes += '<option>'+ i +'</option>'
          }
        }

        this.createPopover();
      },

      changeYear: function() {
        this.popoverYear = 4;
      },

      createPopover: function() {
        console.log(this.company)
        var year = this.popoverYear
        var month = this.popoverMonth
        var day = this.popoverDay

        var startHours = this.startHours;
        var endHours = this.endHours;
        var minutes = this.minutes;

        this.$popover = $('.popover-thing').popover({
            placement: 'top',
            html: true,
            content: function(){

              return '<div class="popover-body"><div class="start-time">'+ day + '<select>'+ startHours +'</select> : <select>'+ minutes +'</select><select><option>AM</option><option>PM</option></select> <br></div><p style="color: black;">to</p> <div class="end-time"><select>'+ endHours +'</select> : <select>'+ minutes +'</select><select><option>AM</option><option selected>PM</option></select></div><hr><div class="form-button"><button ' + sayHello + '">Submit</button></div></div>'
            }

        })
      },

      redrawPopover: function(year, month, day) {


        var year = year;
        var month = month;
        var date = day;
        var company = this.company;

        var startHours = this.startHours;
        var endHours = this.endHours;
        var minutes = this.minutes;

        var title = 'Add Shift for ' + (month + 1) + '-' + day + '-' + year


        $('.popover-thing').attr('data-original-title', title);
        $('.popover-thing').attr('data-content', function(){
          var script = "<script>$('#popoverButton').click(function(e){$.ajax({type:'POST',Accept: 'application/json', url:'/api/v1/shifts',data: {year_start: $('#popoverYear').val(),month_start: $('#popoverMonth').val(),day_start: $('#popoverDay').val(),hour_start: $('#popoverHourStart').val(),min_start: $('#popoverMinStart').val(),hour_end: $('#popoverHourEnd').val(),min_end: $('#popoverMinEnd').val(),company_id: $('#companyId').val()},success: function(result){ window.location.href ='/shifts/'+ result['id']}})})</script>"

          return script + '<input id="companyId" type="hidden" name="company_id" value="'+ company +'"><input id="popoverYear"type="hidden" name="year_start" value="'+ year +'"><input type="hidden" id="popoverMonth" name="month_start" value="'+ (month + 1) +'"><input type="hidden" id="popoverDay" name="day_start" value="'+ day +'"><div class="popover-body"><div class="start-time"><select id="popoverHourStart" name="hour_start">'+ startHours +'</select> : <select id="popoverMinStart" name="min_start">'+ minutes +'</select><br></div><p style="color: black;">to</p> <div class="end-time"><select id="popoverHourEnd" name="hour_end">'+ endHours +'</select> : <select id="popoverMinEnd" name="min_end">'+ minutes +'</select></div><hr><div class="form-button"><button id="popoverButton">Submit</button></div></div>'

          // <select name="startAmPm"><option>AM</option><option>PM</option></select>
          // <select name="endAmPm"><option>AM</option><option selected>PM</option></select>

        });

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