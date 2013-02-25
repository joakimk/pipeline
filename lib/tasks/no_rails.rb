desc "Run the integrated specs"
task :spec do
  system("rspec", *Dir["spec/**/*_spec.rb"]) || exit(1)
end

namespace :spec do
  desc "Run the unit tests"
  task :unit do
    spec_helper_path = File.expand_path("unit/spec_helper.rb")
    system("rspec", "-r#{spec_helper_path}", *Dir["unit/**/*_spec.rb"]) || exit(1)
  end
end

task :default => [ :"spec:unit", :spacer, :"spec" ]

task :spacer do
  puts
end

def lines_for(type)
  `cat $(find app/repositories/#{type}* 2> /dev/null|grep '.rb'|xargs)|wc -l`.chomp.strip
end

desc "Some code stats"
namespace :deployer do
  task :code_stats do
    puts "Number of lines in the repository:\t\t #{lines_for("ar")}"
  end
end
