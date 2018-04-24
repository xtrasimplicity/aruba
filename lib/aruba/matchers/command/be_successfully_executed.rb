require 'rspec/expectations/version'

require 'aruba/matchers/command/have_exit_status'
require 'aruba/matchers/command/have_finished_in_time'

# @!method be_successfuly_executed
#   This matchers checks if execution of <command> was successful
#
#   @return [Boolean] The result
#
#     false:
#     * if command was not successful
#     true:
#     * if command was successful
#
#   @example Use matcher
#
#     RSpec.describe do
#       it { expect(last_command_started).to be_successfully_executed }
#       it { expect(last_command_started).not_to be_successfully_executed }
#       it { expect(last_command_started).to have_failed_running }
#     end
RSpec::Matchers.define :be_successfully_executed do
  match do |actual|
    @old_actual = actual
    @actual     = @old_actual.commandline

    expect(@old_actual).to have_exit_status(0)
  end
end

RSpec::Matchers.define_negated_matcher :have_failed_running, :be_successfully_executed
RSpec::Matchers.alias_matcher :have_executed_successfully, :be_successfully_executed