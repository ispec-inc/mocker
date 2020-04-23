module MocMock
  module Commands
    class Usage
      def self.exec(*args)
        puts "New:"
        puts "  create new project"
        puts "  mocmock new [PROJECT_NAME]"
        puts "Init:"
        puts "  initialize a project"
        puts "  mocmock init"
        puts "Load:"
        puts "  load the yaml file"
        puts "  mocmock load"
      end
    end
  end
end

