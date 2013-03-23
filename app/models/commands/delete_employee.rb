# coding: utf-8
require 'employee'
require 'command_base'

# 従業員削除コマンド用パラメータ
class DeleteEmployeeCommandParams < CommandParamsBase
  attr_reader :employee_id

  MIN_ARGUMENT_COUNT = 1

  MAX_ARGUMENT_COUNT = 1

  protected
  def validate_args
    args_len = @args.length
    if args_len < MIN_ARGUMENT_COUNT || args_len > MAX_ARGUMENT_COUNT
      raise InvalidArgumentsError
    end
  end

  def do_parse
    @employee_id = @args[0].to_i
  end

end

# 従業員削除コマンド
class DeleteEmployeeCommand < CommandBase
  COMMAND_PARAM_CLASS = DeleteEmployeeCommandParams
  protected
  def do_execute
    employee = Employee.find_by_id(@params.employee_id)
    employee.destroy
  end
end

