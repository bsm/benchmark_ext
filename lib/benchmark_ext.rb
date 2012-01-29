require 'benchmark_ext.so'

module Benchmark

  #
  # Returns the time used to execute the given block as a
  # Benchmark::Tms object.
  #
  def measure(label = "", &block) # :yield:
    t0 = Process.times
    rl = realtime(&block)
    t1 = Process.times
    Benchmark::Tms.new(t1.utime  - t0.utime,
                       t1.stime  - t0.stime,
                       t1.cutime - t0.cutime,
                       t1.cstime - t0.cstime,
                       rl,
                       label)
  end
  module_function :measure

end
