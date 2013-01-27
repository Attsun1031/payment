# coding: utf-8

require 'spec_helper'
require 'commands/add_employee.rb'

describe AddEmployeeCommand do
  describe "execute" do
    context "success to add" do
      before do
        args = ['jon', 'Tokyo', 'H', '1000']
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
      @param.salary_type.should == SalaryType::HOURLY
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
      @param.salary_type.should == SalaryType::MONTHLY
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
      @param.salary_type.should == SalaryType::MONTHLY
      @param.salary_unit.should == 200000
      @param.commissioned.should == 100000
    end
  end

  context "invalid salary type" do
    before do
      args = ['kate', 'Kobe', 'M', '200000', '100000']
      @param = AddEmployeeCommandParams.new(args)
    end

    it "should parse params" do
      proc {
        @param.parse
      }.should raise_error(InvalidSalaryTypeError)
    end
  end
end
