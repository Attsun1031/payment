# coding: utf-8

class CommandRunner
  COMMAND_MAP = {
    :AddEmp => AddEmployeeCommand
  }

  def run args
    command = COMMAND_MAP[args[0].intern].new args[1..args.length]
    command.execute
    return 0
  end
end
