if ENV['LOAD_PROFILE']
  SLOW = (ENV['SLOW'] && ENV['SLOW'].to_f) || 0.05

  puts "profiling enabled."
  module Kernel
    def self.define_profiling_method(method)
      alias_method "old_#{method}", method

      define_method(method) do |*opts|
        start_time = Time.now
        ret = send("old_#{method}", *opts)
        elapsed_time = Time.now - start_time

        if elapsed_time > SLOW
          puts "Slow #{method}: #{opts.first} #{(elapsed_time * 1000.0).to_i} ms"
        end

        ret
      end
    end

    [ :require, :load ].each do |method|
      define_profiling_method(method)
    end
  end
end
