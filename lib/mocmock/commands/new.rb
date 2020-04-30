require 'net/http'
require 'uri'

module MocMock
  module Commands
    class New
      BaseUrl = "https://raw.githubusercontent.com/ispec-inc/mocmock/master/inventory"
      RouterUrl = "https://raw.githubusercontent.com/ispec-inc/mocmock/master/lib/mocmock/router.rb"
      Directories = %w(
        lib
        lib/mocmock
        config
        jsons
        views
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

          MocMock::Commands::Usage.exec :new && return if dir.nil?

          Directories.each do |d|
            FileUtils.mkdir_p("#{dir}/#{d}")
          end

          all_files = Files.map{ |f| "#{BaseUrl}/#{f}" } << RouterUrl

          all_files.each do |f|
            uri = URI.parse f
            str = Net::HTTP.get_response(uri).body rescue nil

            File.open("#{dir}/#{f}", "w"){ |file| file.puts str }
          end

          puts "Project is Created"
        end
      end
    end
  end
end
