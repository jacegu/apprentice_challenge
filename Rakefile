def run_tests_in(dir)
  entries = Dir.entries(dir).reject!{ |e| e == '.' or e == '..' or e =~ /.+\.swp/ }
  entries.map{ |e| File.join(dir, e) }.each do |entry|
    run_tests_in(entry) if File.directory?(entry)
    if entry =~ /.+_tests\.rb/
      STDERR.puts "\n#{entry}"
      load entry
    end
  end
end

desc 'runs the tests'
task :test do
  $: << File.join(File.expand_path(File.dirname(__FILE__)), 'test')
  require 'test_helper.rb'
  run_tests_in('test')
end

desc 'run the engine'
task :run do
  load 'bin/run_engine.rb'
end

task :default => [:test]
