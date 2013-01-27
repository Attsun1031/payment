# coding: utf-8

class AddEmployeeCommand
  def initialize args
  end

  def execute
    return 0
  end
end

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
        @commissioned = @args[4]
      end
    else
      raise InvalidSalaryTypeError
    end
  end
end

class InvalidSalaryTypeError < StandardError
end
