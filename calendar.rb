# frozen_string_literal: true
require_relative 'colors'

class Calendar
  COUNT_DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].freeze
  DAYS_IN_WEEK = %w[Mon Tue Wed Thu Fri Sat Sun].freeze

  def call
    @day_in_week = day_in_week
    @days_in_month = days_in_month
    if @day_in_week.empty? || @days_in_month.empty?
      start_day_in_month = Time.local(Time.now.year + Time.now.month / 12, Time.now.month % 12).wday
      puts format_calendar(start_day_in_month, days_in_current_month)
    else
      puts format_calendar(@day_in_week.to_i, @days_in_month.to_i)
    end
  end

  private

  def day_in_week
    puts 'Enter day of week '
    day = gets.chomp
    if day.to_i <= 7
      return day
    else
      puts 'You enter bad number of week'
      day_in_week
    end
  end

  def days_in_month
    print 'Enter day in month '
    days = gets.chomp
    if days.empty? || (days.to_i <= 31 && days.to_i >= 28)
      return days
    else
      puts 'You enter bad count days of month'
      days_in_month
    end
  end

  def format_calendar(offset, month_length)
    [
      * DAYS_IN_WEEK,
      * Array.new(offset - 1),
      * (1..month_length)
    ].each_slice(7).map do |week|
      week.map do |date|
        if %w[Sat Sun].include? date
          '%3s'.red % date
        elsif date == Time.now.day && (@day_in_week.empty? || @days_in_month.empty?)
          '%3s'.green % date
        else
          '%3s' % date
        end
      end.join ' '
    end
  end

  def days_in_current_month
    month = Time.now.month
    year = Time.now.year
    return 29 if month == 2 && Date.gregorian_leap?(year)
    COUNT_DAYS_IN_MONTH[month - 1]
  end
end

Calendar.new.call
