$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

require "minitest/autorun"
require "minitest/pride"
require "pry"
require "fileutils"
require "add_module"

describe "AddModule" do
  subject { AddModule.new(test_file) }
  
  let(:fixture_path)  { File.expand_path("fixtures", File.dirname(__FILE__))}
  let(:template_file) {"#{fixture_path}/sample_ruby_file.rb" }
  let(:test_file)     {"#{fixture_path}/sample_ruby_file_copy.rb" }
  
  before do
    FileUtils.rm(test_file) if File.exists?(test_file)
    FileUtils.cp(template_file, test_file)
  end

  it "adds module to a file" do
    subject.add("Web")
    assert_equal "module Web\n", File.readlines(test_file)[0]
  end
end

