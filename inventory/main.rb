require 'sinatra'
require 'sinatra/json'
require "sinatra/cors"

Dir[File.dirname(__FILE__) + '/lib/**/*'].each(&method(:require))

routes = MocMock::Router.routes

set :allow_origin, "*"
set :allow_methods, "GET,HEAD,POST,PATCH,DELETE"
set :allow_headers, "content-type,if-modified-since"
set :expose_headers, "location,link"

helpers do
  def prettry_json(str)
    MocMock::ViewHelper.prettry_json(str)
  end
end

routes.each do |route|
  eval <<~"EOS"
    #{route.http_method} '#{route.path_for_sinatra}' do
      content_type :json

      json(#{route.res}, encoder: :to_json)
    end
  EOS
end

get '/' do
  @routes = routes
  erb :index
end

