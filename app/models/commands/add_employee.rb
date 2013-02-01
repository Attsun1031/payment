# coding: utf-8
require 'employee'

# 従業員追加コマンド
class AddEmployeeCommand
  def initialize args
    log_name = File.join(Rails.root, 'log', '%s.log' % self.class.name)
    @logger = ActiveSupport::BufferedLogger.new(log_name)
    parse_args args
  end

  def execute
    @logger.info "START %s" % self.class.name
    do_execute
    @logger.info "END %s" % self.class.name
  end

  private
  def do_execute
    new_emp = Employee.new
    new_emp.name = @params.name
    new_emp.address = @params.address
    new_emp.salary_type = @params.salary_type
    new_emp.salary_unit = @params.salary_unit
    new_emp.commissioned = @params.commissioned
    new_emp.save
  end

  def parse_args args
    @params = AddEmployeeCommandParams.new(args)
    @params.parse
  end
end

# 従業員追加コマンド用パラメータ
class AddEmployeeCommandParams
  attr_reader :name, :address, :salary_type, :salary_unit, :commissioned

  MIN_ARGUMENT_COUNT = 4

  def initialize args
    @args = args
  end

  # 引数を解析する
  def parse
    validate_args
    do_parse
  end

  private

  def validate_args
    if @args.length < MIN_ARGUMENT_COUNT
      raise InvalidArgumentsError, "Insufficient Arguments. arguments: %s" % @args
    end
  end

  def do_parse
    @name = @args[0]
    @address = @args[1]
    @salary_unit = @args[3].to_i
    parse_salary_type
  end

  # 給料支払方法を決める
  # H => 時給
  # S => 月給
  # C => 月給 + 成果報酬
  def parse_salary_type
    salary_type = @args[2]
    if salary_type == "H"
      @salary_type = Salary::HOURLY

    elsif ["S", "C"].include? salary_type
      @salary_type = Salary::MONTHLY

      if salary_type == "C"
        if @args.length < 5
          raise InvalidArgumentsError,
            "Commissioned Employee specified, but no commissioned. arguments: %s" % @args
        end
        @commissioned = @args[4].to_i
      end

    else
      raise Salary::InvalidSalaryTypeError
    end
  end
end

class InvalidArgumentsError < StandardError
end
