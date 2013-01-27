# coding: utf-8

class AddEmployeeCommand
  def initialize args
  end

  def execute
    return 0
  end
end

class AddEmployeeCommandParams
  attr_reader :name, :address, :salary_type, :salary_unit

  SALARY_TYPE_MAP = {
    :H => Employee::SalaryType::HOURLY,
    :M => Employee::SalaryType::MONTHLY
  }

  def initialize args
    @args = args
  end

  def parse
    @name = @args[0]
    @address = @args[1]
    @salary_type = SALARY_TYPE_MAP[@args[2].intern]
    @salary_unit = @args[3].to_i
  end
end
