require_relative "./mocmock/version"
Dir['./lib/mocmock/commands/**/*'].each(&method(:require))
require 'fileutils'

module MocMock
  class Error < StandardError; end
  COMMAND_LIST = %w(
    new
    load
  )

  class << self
    def command(args)
      command, *arg = args

      is_valid = valid_command(command)
      unless is_valid
        MocMock::Commands::Usage.exec
        return
      end

      klass = begin
        case command
        when "new" then MocMock::Commands::New
        when "load" then MocMock::Commands::Load
        else MocMock::Commands::Usage
        end
      end

      klass.exec(*arg)
    end

    private

    def valid_command(command)
      COMMAND_LIST.include? command
    end
  end
end
