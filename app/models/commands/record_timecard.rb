# coding: utf-8
require 'timecard'
require 'command_base'

# 従業員削除コマンド用パラメータ
class RecordTimecardCommandParams < CommandParamsBase
  attr_reader :employee_id, :record_date, :hours

  MIN_ARGUMENT_COUNT = 3

  MAX_ARGUMENT_COUNT = 3

  protected
  def validate_args
    args_len = @args.length
    if args_len < MIN_ARGUMENT_COUNT || args_len > MAX_ARGUMENT_COUNT
      raise InvalidArgumentsError
    end
  end

  def do_parse
    @employee_id = @args[0].to_i
    @record_date = RecordDate.from_str(@args[1])
    @hours = WorkingHours.from_str(@args[2])
  end
end

# 従業員削除コマンド
class RecordTimecardCommand < CommandBase
  COMMAND_PARAM_CLASS = RecordTimecardCommandParams
  protected
  def do_execute
    employee_id = @params.employee_id
    record_date = @params.record_date
    hours = @params.hours
    Timecard.record(employee_id, record_date, hours)
  end
end

