guard 'kitchen' do
  watch(%r{spec/.+})
  watch(%r{^recipes/(.+)\.rb$})
  watch(%r{^attributes/(.+)\.rb$})
  watch(%r{^files/(.+)})
  watch(%r{^templates/(.+)})
  watch(%r{^providers/(.+)\.rb})
  watch(%r{^resources/(.+)\.rb})
end

guard 'rspec' do
  watch('spec/spec_helper.rb')
  watch(%r{spec/.+})
  watch(%r{^recipes/(.+)\.rb$})
  watch(%r{^libraries/(.+)\.rb$})
end
