require "fileutils"
require "tempfile"

class AddModule
  def initialize(file_name)
    @file_name = file_name
    @tmp_file  = Tempfile.new(file_name)
  end

  def add(name)
    @tmp_file.puts("module #{name}")
    File.open(@file_name, "r") do |f|
      f.each {|line| @tmp_file.puts("  " + line)}
    end
    @tmp_file.puts("end")
    FileUtils.cp(@tmp_file.path, @file_name)
  end
end

