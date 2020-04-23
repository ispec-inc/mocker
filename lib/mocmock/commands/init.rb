module MocMock
  module Commands
    class Init
      INVENTORY = "inventory"

      def self.exec(*args)
        FileUtils.mkdir_p(dir)

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
