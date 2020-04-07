require 'sinatra'
require 'pry'

Dir[File.dirname(__FILE__) + '/lib/**/*'].each {|file| require file }

routes = Mocker::Router.routes

routes.each do |route|
  eval <<-"TEXT"
    #{route.http_method} '/#{route.endpoint}' do
      content_type :json

      #{route.json}
    end
  TEXT
end

get '/' do
  @routes = routes
  erb :index
end
