# coding: utf-8
require 'spec_helper'

describe CommandRunner do
  context "add hourly rate employee" do
    it "should add employee" do
      result = CommandRunner.run ["AddEmp", "田口", "埼玉県熊谷市", "H", 1000]
      result.should == 0
      emp = Employee.find_by_name("田口")
      emp.address.should == "埼玉県熊谷市"
      emp.salary_type.should == Salary::HOURLY
      emp.salary_unit.should == 1000
      emp.commissioned.should == nil
    end
  end

  context "add monthly rate employee" do
    it "should add employee" do
      result = CommandRunner.run ["AddEmp", "田口", "埼玉県熊谷市", "S", 200000]
      result.should == 0
      emp = Employee.find_by_name("田口")
      emp.address.should == "埼玉県熊谷市"
      emp.salary_type.should == Salary::MONTHLY
      emp.salary_unit.should == 200000
      emp.commissioned.should == nil
    end
  end

  context "add commissioned employee" do
    it "should add employee" do
      result = CommandRunner.run ["AddEmp", "田口", "埼玉県熊谷市", "C", 200000, 100000]
      result.should == 0
      emp = Employee.find_by_name("田口")
      emp.address.should == "埼玉県熊谷市"
      emp.salary_type.should == Salary::MONTHLY
      emp.salary_unit.should == 200000
      emp.commissioned.should == 100000
    end
  end
end
