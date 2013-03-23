# coding: utf-8
require 'add_employee'
require 'delete_employee'

module CommandFactory
  COMMAND_MAP = {
    :AddEmp => AddEmployeeCommand,
    :DelEmp => DeleteEmployeeCommand
  }

  def self.create_command args
    return COMMAND_MAP[args[0].intern].new args[1..args.length]
  end
end
