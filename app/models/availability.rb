class Availability < ApplicationRecord
  belongs_to :employee

  enum day_of_week: { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6}


  def time_available


    if time_start.localtime.hour > 12
      am_pm = 'PM'
    else
      am_pm = 'AM'
    end

    starting_hour = time_start.localtime.hour % 12

    if time_start.localtime.min < 10
      starting_min = "0#{time_start.localtime.min}"
    else
      starting_min = time_start.localtime.min
    end

    start = "#{starting_hour}:#{starting_min}#{am_pm}"

    if time_end.localtime.hour > 12
      am_pm = 'PM'
    else
      am_pm = 'AM'
    end
    ending_hour = time_end.localtime.hour % 12

    if time_end.localtime.min < 10
      end_min = "0#{time_end.localtime.min}"
    else
      end_min = time_end.localtime.min
    end

    ending_time = "#{ending_hour}:#{end_min}#{am_pm}"


    "#{start} - #{ending_time}"

  end

end
