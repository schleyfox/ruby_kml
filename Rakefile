require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/contrib/rubyforgepublisher'

require File.join(File.dirname(__FILE__), 'lib/kml', 'version')

PKG_BUILD       = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
PKG_NAME        = 'kmlr'
PKG_VERSION     = KML::VERSION::STRING + PKG_BUILD
PKG_FILE_NAME   = "#{PKG_NAME}-#{PKG_VERSION}"
PKG_DESTINATION = ENV["PKG_DESTINATION"] || "../#{PKG_NAME}"

RELEASE_NAME  = "REL #{PKG_VERSION}"

RUBY_FORGE_PROJECT = "kmlr"
RUBY_FORGE_USER    = "aeden"

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the library.'
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

PKG_FILES = FileList[
  'CHANGELOG',
  'README',
  'TODO',
  'Rakefile',
  'bin/**/*',
  'doc/**/*',
  'lib/**/*',
] - [ 'test' ]

spec = Gem::Specification.new do |s|
  s.name = 'kmlr'
  s.version = PKG_VERSION
  s.summary = "Library to product KML files."
  s.description = <<-EOF
    KMLr is a Ruby library which can be used to construct Keyhole Markup Language files.
  EOF

  s.add_dependency('rake',                '>= 0.7.1')

  s.rdoc_options << '--exclude' << '.'
  s.has_rdoc = false

  s.files = PKG_FILES.to_a.delete_if {|f| f.include?('.svn')}
  s.require_path = 'lib'

  s.author = "Anthony Eden"
  s.email = "anthonyeden@gmail.com"
  s.homepage = "http://kmlr.rubyforge.org/"
  s.rubyforge_project = "kmlr"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
  pkg.need_tar = true
  pkg.need_zip = true
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

desc "Publish the release files to RubyForge."
task :release => [ :package ] do
  `rubyforge login`

  for ext in %w( gem tgz zip )
    release_command = "rubyforge add_release kmlr #{PKG_NAME} 'REL #{PKG_VERSION}' pkg/#{PKG_NAME}-#{PKG_VERSION}.#{ext}"
    puts release_command
    system(release_command)
  end
end

desc "Publish the API documentation"
task :pdoc => [:rdoc] do 
  Rake::SshDirPublisher.new("aeden@rubyforge.org", "/var/www/gforge-projects/kmlr/rdoc", "rdoc").upload
end

desc "Reinstall the gem from a local package copy"
task :reinstall => [:package] do
  windows = RUBY_PLATFORM =~ /mswin/
  sudo = windows ? '' : 'sudo'
  gem = windows ? 'gem.bat' : 'gem'
  `#{sudo} #{gem} uninstall -x -i #{PKG_NAME}`
  `#{sudo} #{gem} install pkg/#{PKG_NAME}-#{PKG_VERSION}`
end
