task :spec do
  system("rspec", *Dir["spec/**/*_spec.rb"]) || exit(1)
end

namespace :spec do
  task :unit do
    spec_helper_path = File.expand_path("unit/spec_helper.rb")
    system("rspec", "-r#{spec_helper_path}", *Dir["unit/**/*_spec.rb"]) || exit(1)
  end
end

task :default => [ :"spec:unit", :spec ]

def lines_for(type)
  `cat $(find app/models/repository/#{type}* 2> /dev/null|grep '.rb'|xargs)|wc -l`.chomp.strip
end

desc "Some code stats"
namespace :deployer do
  task :code_stats do
    puts "Number of lines in the memory repository:\t #{lines_for("memory")}"
    puts "Number of lines in the pg repository:\t\t #{lines_for("pg")}"
    puts "Number of lines shared between repositories:\t #{lines_for("common")}"
  end
end
