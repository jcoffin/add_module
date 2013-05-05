require "rake/testtask"

namespace :test do
  task default: :unit

  Rake::TestTask.new do |t|
    t.name    = :unit
    t.pattern = "test/**/*_test.rb"
  end
end

task default: "test:unit"
