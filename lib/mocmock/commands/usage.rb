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
          eval "new.#{command}"
        end
      end

      def new
        puts <<~"EOS"
        New:
          - Create new project
          mocmock new [PROJECT_NAME]
        EOS
      end

      def load
        puts <<~"EOS"
        Load:
          - Load routings and create jsons
          mocmock load
        EOS
      end
    end
  end
end

