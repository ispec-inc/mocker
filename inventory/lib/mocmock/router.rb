module MocMock
  class Router
    attr_reader :path_for_sinatra,
      :path,
      :http_method,
      :json,
      :req,
      :res

    HTTP_METHODS = %w(
      get
      post
      patch
      put
      delete
      head
      options
      trace
      connect
    ).freeze

    class << self
      def routes
        route_file = "config/routes.yml"
        unless File.exists? route_file
          puts "Cannot file 'config/routes.yml'"
          return
        end

        endpoints = YAML.load_file(route_file)

        if endpoints["routes"].nil?
          puts "yaml need root key `routes`"
          return []
        end

        valid_endpoints(endpoints)
      end

      def valid_endpoints(endpoints)
       get = ->(path, hash){
          hash.map do |k, v|
            case v
            when Hash
              get.call("#{path}/#{k}", v)
            when Array
              { "#{path}/#{k}" => v }
            end
          end
        }

        items = get.call("", endpoints["routes"]).flatten

        valid_endpoints = []
        items.each do |item|
          item.each do |endpoint, http_methods|
            http_methods.each do |http_method|
              route = new(endpoint, http_method)

              if route.invalid_method?
                puts "detacted invalid http_method `#{http_method}`"
                next
              end

              valid_endpoints << route
            end
          end
        end

        valid_endpoints
      end
    end

    def initialize(endpoint, http_method)
      file = "jsons/#{endpoint}/#{http_method}.json"
      json = File.open(file) { |f| JSON.load(f).to_h } if File.exists? file

      @res= json&.dig("response").to_h
      @req = json&.dig("request").to_h
      @path = endpoint
      @path_for_sinatra = endpoint.gsub(":id", "*")
      @http_method = valid_method(http_method)
      @invalid = @http_method.nil? || json.nil?
    end

    def invalid_method?
      @http_method.nil?
    end

    private

    def valid_method(method)
      HTTP_METHODS.include?(method) ? method : nil
    end
  end
end
