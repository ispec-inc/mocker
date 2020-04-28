require 'net/http'
require 'uri'

module MocMock
  module Commands
    class New
      BaseUrl = "https://raw.githubusercontent.com/ispec-inc/mocmock/master/inventory"
      Directories = %w(
        lib
        lib/mocmock
        config
        jsons
        view
      )

      Files = %w(
        main.rb
        Gemfile
        lib/mocmock.rb
        lib/mocmock/router.rb
        lib/mocmock/view_helper.rb
        config/routes.yml
        views/index.erb
        jsons/.gitkeep
      )

      class << self
        def exec(*args)
          dir = args[0]
          if dir.nil?
            puts_usage
            return
          end

          Directories.each do |d|
            FileUtils.mkdir_p("#{dir}/#{d}")
          end

          Files.each do |f|
            uri = URI.parse "#{BaseUrl}/#{f}"
            str = Net::HTTP.get_response(uri).body rescue nil

            File.open("#{dir}/#{f}", "w"){ |file| file.puts str }
          end

          puts "Project is Created"
        end

        private

        def puts_usage
          puts "ERROR:"
          puts "  Give Project name"
          puts
          puts "USAGE:"
          puts "  mocmock new [PROJECT_NAME]"
        end
      end
    end
  end
end
