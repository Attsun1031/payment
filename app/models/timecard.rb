require 'date'
require 'bigdecimal'

class Timecard < ActiveRecord::Base
  belongs_to :employee
  attr_accessible :hours, :record_date

  def self.record employee_id, record_date, working_hours
    employee = Employee.find_by_id(employee_id)
    unless employee.is_hourly_payment
      return nil
    end

    timecard = Timecard.new
    timecard.employee_id = employee_id
    timecard.record_date = record_date.value
    timecard.hours = working_hours.value
    timecard.save
    return timecard
  end
end

class WorkingHours
  MAX_SCALE = 1
  attr_reader :value

  def initialize hours
    @value = hours
  end

  def self.from_str str_hours
    hours = BigDecimal.new(str_hours).round(WorkingHours::MAX_SCALE)
    return WorkingHours.new(hours)
  end
end

class RecordDate
  attr_reader :value

  def initialize record_date
    @value = record_date
  end

  def self.from_str str_date, format = '%Y%m%d'
    date = Date.strptime(str_date, format)
    return RecordDate.new(date)
  end
end
