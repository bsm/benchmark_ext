require 'spec_helper'

describe Benchmark do

  subject do
    described_class
  end

  let :native_instance do
    klass = Class.new
    klass.send :include, described_class
    klass.new
  end

  let :ruby_instance do
    klass = Class.new
    klass.send :include, RubyBenchmark
    klass.new
  end

  def meter(cycles, &block)
    described_class.realtime { cycles.times(&block) }
  end

  it { should respond_to(:timestamp) }
  it { should respond_to(:realtime) }

  it 'should allow module inclusion of native implementation' do
    native_instance.private_methods.should include(:realtime)
    ruby_instance.private_methods.should include(:realtime)

    native = meter(10_000) { native_instance.send(:realtime) { nil } }
    ruby   = meter(10_000) { ruby_instance.send(:realtime) { nil } }
    native.should < ruby
    (ruby / native).should > 5
  end

  describe "timestamp" do

    it 'should return a timestamp' do
      ts = described_class.timestamp
      ts.should be_instance_of(Float)
      now = Time.now.to_f
      ts.should < now
      ts.should > (now - 0.1)
    end

  end

  describe "realtime" do

    it 'should require a block' do
      lambda {
        described_class.realtime
      }.should raise_error(ArgumentError, "A block must be provided.")
    end

    it 'should calculate the realtime' do
      ms = described_class.realtime { sleep(0.001) }
      ms.should be_instance_of(Float)
      ms.should >= 0.001
      ms.should <  0.0015
    end

    it 'should be faster than the pure-ruby implementation' do
      native = meter(10_000) { described_class.realtime { } }
      ruby   = meter(10_000) { RubyBenchmark.realtime { } }
      native.should < ruby
      (ruby / native).should > 2
    end

  end

  describe "measure" do

    it 'should return a measurement' do
      tms = described_class.measure { sleep(0.001) }
      tms.should be_instance_of(Benchmark::Tms)
      tms.real.should >= 0.001
      tms.real.should <  0.0015
    end

    it 'should use native realtime' do
      Time.should_not_receive(:now)
      described_class.measure {}
    end

  end

end
