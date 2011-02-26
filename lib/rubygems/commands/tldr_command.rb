require 'fileutils'
require 'find'
require 'rubygems/command'

##
# TL;DR your gems with <tt>gem tldr</tt>

class Gem::Commands::TldrCommand < Gem::Command

  VERSION = '1.0'

  def initialize
    super 'tldr', 'Documentation? Tests? They use too much disk space!'

    add_option '--dry-run', "don't do anything" do |value, options|
      options[:dry_run] = true
    end
  end

  def usage # :nodoc:
    program_name
  end

  def execute
    @verbose = Gem.configuration.really_verbose

    if @verbose then
      if options[:dry_run] then
        extend FileUtils::DryRun
      else
        extend FileUtils::Verbose
      end
    elsif options[:dry_run] then
      extend FileUtils::NoWrite
    else
      extend FileUtils
    end

    beginning_size = total_size

    Gem.source_index.each do |name, spec|
      say "TL;DR #{name}"
      Dir.chdir spec.full_gem_path do
        remove_tests spec
        remove_built_documentation spec
        remove_build_artifacts spec
        remove_file_comments spec
      end
    end

    ending_size = total_size

    saved = beginning_size - ending_size

    say "start: #{beginning_size}B end: #{ending_size}B saved: #{saved}B"
  end

  ##
  # Find the total size of your Gem path directories

  def total_size
    size = 0

    Gem.path.each do |directory|
      Find.find directory do |path|
        stat = File.stat path
        next unless stat.file?
        size += stat.size
      end
    end

    size
  end

  ##
  # Remove the documentation for +spec+

  def remove_built_documentation spec
    doc_dir = File.join spec.installation_path, 'doc', spec.full_name

    say "\tRemoving built documentation" if @verbose
    rm_rf doc_dir
  end

  ##
  # Remove build artifacts for C extensions from +spec+

  def remove_build_artifacts spec
    spec.extensions.each do |extension|
      next unless extension =~ /extconf\.rb$/
      extension_dir = File.dirname extension

      say "\tRemoving build artifacts in #{extension_dir}" if @verbose

      Dir["#{extension_dir}/**/*.{c,h,java,o}"].each do |artifact|
        rm_f artifact
      end

      Dir["#{extension_dir}/**/*.dSYM"].each do |artifact|
        rm_rf artifact
      end

      rm_f File.join(extension_dir, 'Makefile')
      rm_f File.join(extension_dir, 'extconf.rb')
      rm_f File.join(extension_dir, 'mkmf.log')
    end
  end

  ##
  # Remove comments in the ruby files of +spec+

  def remove_file_comments spec
    say "\tStripping comments" if @verbose
    return if options[:dry_run]
    spec.require_paths.each do |path|
      Dir["#{path}/**/*.rb"].each do |file|
        ruby = File.read file

        stripped = strip_comments ruby

        open file, 'w' do |io|
          io.write stripped
        end
      end
    end
  end

  ##
  # Remove the tests (and specs) of +spec+

  def remove_tests spec
    say "\tRemoving tests" if @verbose
    Dir['{test,spec}'].each do |dir|
      rm_rf dir
    end
  end

  ##
  # Strips comments out of +ruby+.  Destructive!

  def strip_comments ruby
    ruby.gsub!(/^[ \t]*#[^{@$].*?\r?\n/, '')
    ruby.gsub!(/[ \t]*#[^{@$].*?$/, '')
    ruby
  end

end

