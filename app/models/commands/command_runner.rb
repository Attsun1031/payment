# coding: utf-8
require 'add_employee'

# コマンド実行クラス
class CommandRunner
  COMMAND_MAP = {
    :AddEmp => AddEmployeeCommand
  }

  # コマンドを実行する
  # 実行するコマンドは第一引数と COMMAND_MAP のマッピングで決定される。
  # === Args
  # args :: コマンドライン引数
  # === Return
  # 終了コード :: 0 => 正常
  def self.run args
    command = COMMAND_MAP[args[0].intern].new args[1..args.length]
    command.execute
    return 0
  end
end
