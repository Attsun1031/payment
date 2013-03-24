# coding: utf-8

class Employee < ActiveRecord::Base
  belongs_to :union_member
  attr_accessible :address, :commissioned, :name, :payment_type, :salary_type, :salary_unit

  def is_hourly_payment
    if @salary_type.to_i == Salary::HOURLY
      return true
    else
      return false
    end
  end
end

module Salary
  HOURLY = 0
  MONTHLY = 1

  class InvalidSalaryTypeError < StandardError
  end
end
