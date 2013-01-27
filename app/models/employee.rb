module Employee
  class Employee < ActiveRecord::Base
    belongs_to :union_member
    attr_accessible :address, :commissioned, :name, :payment_type, :salary_type, :salary_unit
  end

  module SalaryType
    HOURLY = 0
    MONTHLY = 1
  end
end
