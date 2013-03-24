# coding: utf-8
require 'spec_helper'

describe CommandRunner do
  context "Timecard" do
    fixtures :employees
    it "should record timecard" do
      result = CommandRunner.run ["Timecard", "1", "20130324", "8.511"]
      result.should == 0

      timecard = Timecard.find(:all)[0]
      timecard.record_date.should == Date.new(2013, 3, 24)
      timecard.hours.to_f.should == 8.5
    end
  end
end
