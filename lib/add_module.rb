require "fileutils"

class AddModule
  def initialize(file_name)
    @file_name = file_name
  end

  def add(name)
    rename_file
    add_module(name)
    append_to_file
  end

  private

  def rename_file
    File.rename(@file_name, backup_file_name)
  end

  def add_module(name)
    File.open(@file_name, "w") do |file|
      file.puts("module #{name}")
    end
  end

  def append_to_file
    File.open(@file_name, "a") do |file|
      File.open(backup_file_name, "r") do |back_up_file|
        back_up_file.each { |line| file.puts line }
      end
    end
  end

  def backup_file_name
    @file_name + ".bak"
  end
end

