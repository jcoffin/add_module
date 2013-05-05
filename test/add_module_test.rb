$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

require "minitest/autorun"
require "minitest/pride"
require "pry"
require "fileutils"
require "add_module"

describe "AddModule" do
  subject { AddModule.new(file) }
  
  let(:fixture_path)  { File.expand_path("fixtures", File.dirname(__FILE__))}
  let(:template_file) {"#{fixture_path}/sample_ruby_file.rb" }
  let(:file)          {"#{fixture_path}/sample_ruby_file_copy.rb" }
  let(:backup_file)   { file + ".bak" }
  
  before do
    FileUtils.rm(file) if File.exists?(file)
    FileUtils.rm(backup_file) if File.exists?(backup_file)
    FileUtils.cp(template_file, file)
  end

  it "leaves lines before the class name alone" do
    subject.add("Web")
    assert_equal "# this is a sample ruby file\n", File.readlines(file)[0]
  end

  it "adds module to a file" do
    subject.add("Web")
    assert_equal "module Web\n", File.readlines(file)[2]
  end

  it "indents the code between the module" do
    subject.add("Web")
    File.readlines(file)[3, 5].each do |line|
      assert_equal "  ", line[0, 2]
    end
  end

  it "adds the closing 'end' for the module" do
    subject.add("Web")
    assert_equal "end\n", File.readlines(file).last
  end
end
