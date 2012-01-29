require 'spec_helper'

describe "sanity checks" do

  describe 'ruby benchmark' do

    it 'should use Time to calculate intervals' do
      Time.should_receive(:now).and_return(Time.at(0))
      Time.should_receive(:now).and_return(Time.at(3))
      ms = RubyBenchmark.realtime {}
      ms.should == 3.0
    end

  end

  describe 'native benchmark' do

    it 'should not use Time' do
      Time.should_not_receive(:now)
      ms = Benchmark.realtime {}
      ms.should < 0.1
    end

  end

end
