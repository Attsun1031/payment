# coding: utf-8
require 'employee'

# 従業員追加コマンド
class AddEmployeeCommand
  def initialize args
    parse_args args
  end

  def execute
    new_emp = Employee.new
    new_emp.name = @params.name
    new_emp.address = @params.address
    new_emp.salary_type = @params.salary_type
    new_emp.salary_unit = @params.salary_unit
    new_emp.commissioned = @params.commissioned
    new_emp.save
  end

  private
  def parse_args args
    @params = AddEmployeeCommandParams.new(args)
    @params.parse
  end
end

# 従業員追加コマンド用パラメータ
class AddEmployeeCommandParams
  attr_reader :name, :address, :salary_type, :salary_unit, :commissioned

  def initialize args
    @args = args
  end

  def parse
    @name = @args[0]
    @address = @args[1]
    @salary_unit = @args[3].to_i
    parse_salary_type
  end

  private

  # 給料支払方法を決める
  # H => 時給
  # S => 月給
  # C => 月給 + 成果報酬
  def parse_salary_type
    salary_type = @args[2]
    if salary_type == "H"
      @salary_type = SalaryType::HOURLY
    elsif ["S", "C"].include? salary_type
      @salary_type = SalaryType::MONTHLY
      if salary_type == "C"
        @commissioned = @args[4].to_i
      end
    else
      raise InvalidSalaryTypeError
    end
  end
end

class InvalidSalaryTypeError < StandardError
end
