# coding: utf-8
require 'spec_helper'

describe CommandRunner do
  context "delete employee" do
    it "should delete employee" do
      result = CommandRunner.run ["DelEmp", 1]
      result.should == 0
      emp = Employee.find_by_name("田口")
    end
  end
end
