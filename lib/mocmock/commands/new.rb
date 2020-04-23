module MocMock
  module Commands
    class New
      def self.exec(*args)
        dir = args[0]
        if dir.nil?
          puts "ERROR:"
          puts "  Give Project name"
          puts
          puts "USAGE:"
          puts "  mocmock new [PROJECT_NAME]"
          return
        end

        MocMock.init dir

      end
    end
  end
end
