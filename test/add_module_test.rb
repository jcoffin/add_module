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
    FileUtils.cp(template_file, file)
  end

  it "adds module to a file" do
    subject.add("Web")
    assert_equal "module Web\n", File.readlines(file)[0]
  end
end
