# coding: utf-8

require 'spec_helper'
require 'commands/record_timecard.rb'

describe RecordTimecardCommand do
  before do
    @logger = mock(ActiveSupport::BufferedLogger)
    @record_date = mock(RecordDate)
    @hours = mock(WorkingHours)
    Timecard.stub(:record)
  end
  describe "execute" do
    context "success to record" do
      it "should call record" do
        args = ['1', '20130103', '8']
        RecordDate.should_receive(:from_str).with('20130103').and_return(@record_date)
        WorkingHours.should_receive(:from_str).with('8').and_return(@hours)
        Timecard.should_receive(:record).with(1, @record_date, @hours)
        RecordTimecardCommand.new(args).execute
      end
    end
  end
end

