# coding: utf-8
require 'command_factory'

# コマンド実行クラス
class CommandRunner
  def self.run args
    command = CommandFactory.create_command args
    command.execute
    return 0
  end
end
