# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

# clear the default task injected by rspec
task(:default).clear

task default: %i[rubocop spec]
