module MocMock
  module Commands
    class Usage
      def self.exec(*args)
        puts "New:"
        puts "  - Create new project"
        puts "  mocmock new [PROJECT_NAME]"
        puts "Load:"
        puts "  - Load routings and create jsons"
        puts "  mocmock load"
      end
    end
  end
end

