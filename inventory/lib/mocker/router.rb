class Mocker::Router
  require 'hashie'
  attr_reader :endpoint, :http_method, :json, :req, :res

  class << self
    def routes
      endpoints = Hashie::Mash.load("config/routes.yml").routes

      list = []
      endpoints.each do |endpoint, http_methods|
        http_methods.each do |http_method|
          list << new(endpoint, http_method)
        end
      end

      list
    end
  end

  def initialize(endpoint, http_method)
    json = Hashie::Mash.load "jsons/#{endpoint}/#{http_method}.json"

    @endpoint = endpoint
    @http_method = http_method
    @res= json.response
    @req = json.request
  end
end
