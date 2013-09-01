class GymTodayServer < Sinatra::Base

  use Rack::Session::Cookie
  use OmniAuth::Strategies::Twitter, Twitter.api_key, Twitter.secret

  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    if(session[:user])
      redirect '/authenticated'
    else
      haml :index, :layout => :default
    end
  end

  get '/authenticated' do
    haml :authenticated, :layout => :default
  end

  ['get', 'post'].each do |method|
    send(method, '/auth/:name/callback') do
      auth = request.env['omniauth.auth']
      user_key = "#{auth[:provider]}_#{auth[:uid]}"
      nickname = auth[:info][:nickname]
      user = UserRepository.find_or_create(user_key, nickname)
      session[:user] = user
      redirect '/'
    end
  end
  post '/auth/:name/callback' do
    puts request.env['omniauth.auth']
  end

  get '/auth/:name/callback' do
    puts request.env['omniauth.auth']
  end

end
