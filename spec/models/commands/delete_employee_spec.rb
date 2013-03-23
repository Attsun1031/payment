# coding: utf-8

require 'spec_helper'
require 'commands/delete_employee.rb'

describe DeleteEmployeeCommand do
  before do
    @logger = mock(ActiveSupport::BufferedLogger)
    @employee = mock(Employee)
  end
  describe "execute" do
    context "success to delete" do
      it "should delete employee" do
        log_name = File.join(Rails.root, 'log', '%s.log' % DeleteEmployeeCommand.name)
        ActiveSupport::BufferedLogger.should_receive(:new).with(log_name).and_return(@logger)
        @logger.should_receive(:info).with("START %s" % DeleteEmployeeCommand.name)
        @logger.should_receive(:info).with("END %s" % DeleteEmployeeCommand.name)

        args = ['1']
        Employee.should_receive(:find_by_id).with(1).and_return(@employee)
        @employee.should_receive(:destroy)
        DeleteEmployeeCommand.new(args).execute
      end
    end
  end
end

