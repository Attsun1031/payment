# coding: utf-8

require 'spec_helper'
require 'commands/command_runner'
require 'commands/add_employee'

describe CommandRunner do
  before do
    @add_employee_command = mock(AddEmployeeCommand)
  end

  describe "run" do
    it "should run command" do
      args = ["AddEmp", 'jon', 'address', "H", "1000"]
      AddEmployeeCommand.should_receive(:new).with(args[1..args.length]).and_return(@add_employee_command)
      @add_employee_command.should_receive(:execute)
      result = CommandRunner.run(args)
      result.should == 0
    end
  end
end
