require 'sinatra'
require 'haml'

class GymToday < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    haml :index, :layout => :default
  end

end
