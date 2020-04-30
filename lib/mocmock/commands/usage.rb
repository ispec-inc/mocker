module MocMock
  module Commands
    class Usage
      class << self
        def exec(command = nil, *_)
          all = instance_methods(false)
          commands = (all & [command]).empty? ? all : [command]

          commands.each(&method(:puts_usage))
        end

        private

        def puts_usage(command)
          eval "new.#{command.to_s}"
        end
      end

      def new
        usage = <<~"EOS"
        New:
          - Create new project
          mocmock new [PROJECT_NAME]
        EOS

        puts usage
      end

      def load
        usage = <<~"EOS"
        Load:
          - Load routings and create jsons
          mocmock load
        EOS

        puts usage

      end
    end
  end
end

