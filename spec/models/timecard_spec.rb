require 'spec_helper'

describe Timecard do
  describe "record" do
    before do
      @employee = mock(Employee)
    end

    it "should record timecard" do
      Employee.should_receive(:find_by_id).with(1).and_return(@employee)
      @employee.stub!(:is_hourly_payment).and_return(true)
      Timecard.any_instance.should_receive(:save)

      timecard = Timecard.record(1, RecordDate.from_str('20130103'), WorkingHours.from_str('1.1'))
      timecard.employee_id.should == 1
      timecard.record_date.should == Date.new(2013, 1, 3)
      timecard.hours.to_f.should == 1.1
    end

    it "should record timecard with over scale" do
      Employee.should_receive(:find_by_id).with(2).and_return(@employee)
      @employee.stub!(:is_hourly_payment).and_return(true)
      Timecard.any_instance.should_receive(:save)

      timecard = Timecard.record(2, RecordDate.from_str('20130103'), WorkingHours.from_str('20.12101'))
      timecard.employee_id.should == 2
      timecard.record_date.should == Date.new(2013, 1, 3)
      timecard.hours.to_f.should == 20.1
    end

    it "should not record timecard" do
      Employee.should_receive(:find_by_id).with(1).and_return(@employee)
      @employee.stub!(:is_hourly_payment).and_return(false)
      Timecard.any_instance.should_not_receive(:save)

      timecard = Timecard.record(1, RecordDate.from_str('20130103'), WorkingHours.from_str('1.1'))
      timecard.should == nil
    end
  end
end
