# coding: utf-8
require 'spec_helper'

describe CommandRunner do
  context "DelEmp" do
    fixtures :employees
    it "should delete employee" do
      result = CommandRunner.run ["DelEmp", 1]
      result.should == 0
      emp = Employee.find_by_id(1)
      emp.should == nil
    end
  end
end
