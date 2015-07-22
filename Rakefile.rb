require 'rake/testtask'

task default: %w[test]

# task :test do
#   ruby "./test/key_generator_test.rb"
#   ruby "./test/offset_calculator_test.rb"
#   ruby "./test/rotation_calculator_test.rb"
#   ruby "./test/string_encryptor_test.rb"
# end

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end
