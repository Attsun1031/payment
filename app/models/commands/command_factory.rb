# coding: utf-8
require 'add_employee'
require 'delete_employee'
require 'record_timecard'

module CommandFactory
  COMMAND_MAP = {
    :AddEmp => AddEmployeeCommand,
    :DelEmp => DeleteEmployeeCommand,
    :Timecard => RecordTimecardCommand
  }

  def self.create_command args
    return COMMAND_MAP[args[0].intern].new args[1..args.length]
  end
end
