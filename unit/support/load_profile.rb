if ENV['LOAD_PROFILE']
  puts "profiling enabled."
  module Kernel
    SLOW = (ENV['SLOW'] && ENV['SLOW'].to_f) || 0.05

    [ :require, :load ].each do |method|
      alias_method "old_#{method}", method

      define_method(method) do |file|
        start_time = Time.now
        ret = send("old_#{method}", file)
        elapsed_time = Time.now - start_time

        if elapsed_time > SLOW
          puts "Slow #{method}: #{file} #{(elapsed_time * 1000.0).to_i} ms"
        end

        ret
      end
    end
  end
end
