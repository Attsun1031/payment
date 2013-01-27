require 'spec_helper'
require 'commands/add_employee.rb'

describe AddEmployeeCommand do
  context "hourly rate" do
    before do
      args = ['jon', 'Tokyo', 'H', 1000]
      @add_emp_command = AddEmployeeCommand.new(args)
    end

    it "should add employee" do
      result = @add_emp_command.execute()
      result.should == 0
      added_emp = Employee.find_by_name("jon")
      added_emp.address.should == 'Tokyo'
      added_emp.salary_type.should == 0
      added_emp.salary_unit.should == 1000
    end
  end
end


describe AddEmployeeCommandParams do
  context "houlry payment employee" do
    before do
      args = ['jon', 'Tokyo', 'H', 1000]
      @parser = AddEmployeeCommandParams.new(args)
    end

    it "should parse params" do
      @parser.parse
      @parser.name.should == 'jon'
      @parser.address.should == 'Tokyo'
      @parser.salary_type.should == SalaryType::HOURLY
      @parser.salary_unit.should == 1000
      @parser.commissioned.should == nil
    end
  end

  context "monthly payment employee" do
    before do
      args = ['tom', 'Yokohama', 'S', 300000]
      @parser = AddEmployeeCommandParams.new(args)
    end

    it "should parse params" do
      @parser.parse
      @parser.name.should == 'tom'
      @parser.address.should == 'Yokohama'
      @parser.salary_type.should == SalaryType::MONTHLY
      @parser.salary_unit.should == 300000
      @parser.commissioned.should == nil
    end
  end

  context "monthly payment and commissioned employee" do
    before do
      args = ['kate', 'Kobe', 'C', 200000, 100000]
      @parser = AddEmployeeCommandParams.new(args)
    end

    it "should parse params" do
      @parser.parse
      @parser.name.should == 'kate'
      @parser.address.should == 'Kobe'
      @parser.salary_type.should == SalaryType::MONTHLY
      @parser.salary_unit.should == 200000
      @parser.commissioned.should == 100000
    end
  end

  context "invalid salary type" do
    before do
      args = ['kate', 'Kobe', 'M', 200000, 100000]
      @parser = AddEmployeeCommandParams.new(args)
    end

    it "should parse params" do
      proc {
        @parser.parse
      }.should raise_error(InvalidSalaryTypeError)
    end
  end
end
