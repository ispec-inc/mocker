module MocMock
  module Commands
    class Load

      def self.exec(*args)
        Dir[File.expand_path('../lib', __FILE__) << '/**/*.rb'].each(&method(:require))

        routes = MocMock::Router.routes

        routes.each do |route|
          path = route.path
          dir = "jsons/#{path}"
          file = "#{dir}/#{route.http_method}.json"

          next if File.exist? file

          FileUtils.mkdir_p(dir)
          FileUtils.touch(file)

          json = <<~"EOS"
          {
            "response": {
            },
            "request": {
            }
          }
          EOS

          File.write(file, json, {mode: "a"})
        end
      end
    end
  end
end

