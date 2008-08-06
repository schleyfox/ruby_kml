require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'erb'

require File.join(File.dirname(__FILE__), 'lib/kml', 'version')

desc "Generate GemSpec file"
task :gem_spec do 
  t = ERB.new(File.read("ruby_kml.gemspec.erb"))
  File.open("ruby_kml.gemspec", "w") do |f| 
    f.write(t.result(binding))
  end
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Clean up after tests.'
task :clean_tests do
  FileList['test/*.kml'].each do |f|
    File.unlink(f)
    puts "Deleting #{f}"
  end
end

desc 'Generate documentation for the library.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'KMLr'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Generate code statistics"
task :lines do
  lines, codelines, total_lines, total_codelines = 0, 0, 0, 0

  for file_name in FileList["lib/**/*.rb"]
    next if file_name =~ /vendor/
    f = File.open(file_name)

    while line = f.gets
      lines += 1
      next if line =~ /^\s*$/
      next if line =~ /^\s*#/
      codelines += 1
    end
    puts "L: #{sprintf("%4d", lines)}, LOC #{sprintf("%4d", codelines)} | #{file_name}"
    
    total_lines     += lines
    total_codelines += codelines
    
    lines, codelines = 0, 0
  end

  puts "Total: Lines #{total_lines}, LOC #{total_codelines}"
end
