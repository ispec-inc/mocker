module MocMock
  module Commands
    class New
      INVENTORY = "inventory"

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

        Dir.glob("#{INVENTORY}/**/*").each do |f|
          new_file = f.sub(INVENTORY, "")

          File.ftype(f) == "file" ?
            FileUtils.cp(f, "#{dir}/#{new_file}") :
            FileUtils.mkdir_p("#{dir}/#{new_file}")
        end
      end
    end
  end
end
