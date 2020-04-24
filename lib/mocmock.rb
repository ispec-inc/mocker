require "pathname"
require 'fileutils'

require_relative 'mocmock/commands/new'
require_relative 'mocmock/commands/usage'
require_relative 'mocmock/commands/load'

# Pathname.glob('./lib/mocmock/**/*.rb').each(&method(:require))

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
