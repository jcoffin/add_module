class AddModule
  def initialize(file_name)
    @file_name     = file_name
    @file_contents = File.readlines(file_name)
  end

  def add(name)
    rename_file
    File.open(@file_name, "w") do |file|
      prefix.each { |line| file.puts(line) }
      file.puts "module #{name}"
      suffix.each { |line| file.puts("  " + line) }
      file.puts("end")
    end
  end

  private

  def rename_file
    File.rename(@file_name, backup_file_name)
  end

  def module_break
    @file_contents.find_index { |l| l =~ /^(module|class) / }
  end

  def prefix
    @file_contents[0, module_break]
  end

  def suffix
    @file_contents[module_break, @file_contents.count]
  end

  def backup_file_name
    @file_name + ".bak"
  end
end

