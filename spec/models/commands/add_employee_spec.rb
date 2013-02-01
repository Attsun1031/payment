# coding: utf-8

require 'spec_helper'
require 'commands/add_employee.rb'

describe AddEmployeeCommand do
  before do
    @logger = mock(ActiveSupport::BufferedLogger)
  end
  describe "execute" do
    context "success to add" do
      it "should add employee" do
        log_name = File.join(Rails.root, 'log', '%s.log' % AddEmployeeCommand.name)
        ActiveSupport::BufferedLogger.should_receive(:new).with(log_name).and_return(@logger)
        @logger.should_receive(:info).with("START %s" % AddEmployeeCommand.name)
        @logger.should_receive(:info).with("END %s" % AddEmployeeCommand.name)

        args = ['jon', 'Tokyo', 'H', '1000']
        AddEmployeeCommand.new(args).execute

        added_emp = Employee.find_by_name("jon")
        added_emp.address.should == 'Tokyo'
        added_emp.salary_type.should == 0
        added_emp.salary_unit.should == 1000
      end
    end
  end
end


describe AddEmployeeCommandParams do
  context "houlry payment employee" do
    before do
      args = ['jon', 'Tokyo', 'H', '1000']
      @param = AddEmployeeCommandParams.new(args)
    end

    it "should parse params" do
      @param.parse
      @param.name.should == 'jon'
      @param.address.should == 'Tokyo'
      @param.salary_type.should == Salary::HOURLY
      @param.salary_unit.should == 1000
      @param.commissioned.should == nil
    end
  end

  context "monthly payment employee" do
    before do
      args = ['tom', 'Yokohama', 'S', '300000']
      @param = AddEmployeeCommandParams.new(args)
    end

    it "should parse params" do
      @param.parse
      @param.name.should == 'tom'
      @param.address.should == 'Yokohama'
      @param.salary_type.should == Salary::MONTHLY
      @param.salary_unit.should == 300000
      @param.commissioned.should == nil
    end
  end

  context "monthly payment and commissioned employee" do
    before do
      args = ['kate', 'Kobe', 'C', '200000', '100000']
      @param = AddEmployeeCommandParams.new(args)
    end

    it "should parse params" do
      @param.parse
      @param.name.should == 'kate'
      @param.address.should == 'Kobe'
      @param.salary_type.should == Salary::MONTHLY
      @param.salary_unit.should == 200000
      @param.commissioned.should == 100000
    end
  end

  context "invalid salary type" do
    it "should raise InvalidSalaryTypeError" do
      proc {
        AddEmployeeCommandParams.new(['kate', 'Kobe', 'M', '200000', '100000']).parse
      }.should raise_error(Salary::InvalidSalaryTypeError)
    end
  end

  context "insufficient arguments" do
    it "should raise InvalidArgumentsError" do
      proc {
        AddEmployeeCommandParams.new(['kate', 'Kobe', 'H']).parse
      }.should raise_error(InvalidArgumentsError)
    end
  end

  context "no commissioned" do
    it "should raise InvalidArgumentsError" do
      proc {
        AddEmployeeCommandParams.new(['kate', 'Kobe', 'C', '100000']).parse
      }.should raise_error(InvalidArgumentsError)
    end
  end
end
