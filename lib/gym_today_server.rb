class GymTodayServer < Sinatra::Base

  include ChallengeHelper

  use Rack::Session::Cookie
  use OmniAuth::Strategies::Twitter, Twitter.api_key, Twitter.secret
  use OmniAuth::Strategies::Facebook, Facebook.api_key, Facebook.secret

  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    if(signed_in?)
      redirect '/authenticated'
    else
      haml :index, :layout => :default
    end
  end

  get '/invites/:uuid' do
    invite = InviteRepository.find(params[:uuid])
    if signed_in? && invite.from?(session[:user])
      redirect '/'
      return
    end
    @inviter = UserRepository.find(invite.owner)
    @accept_path = "/connections/#{params[:uuid]}"
    view = signed_in? ? :authenticated_invite : :unauthenticated_invite
    haml view, :layout => :default
  end

  get '/authenticated' do
    @user = session[:user]
    haml :authenticated, :layout => :default
  end

  post '/log_out' do
    session.clear
    redirect '/'
  end

  post '/invites' do
    content_type :json
    invite = InviteRepository.create(session[:user])
    { :invite_url => url("/invites/#{invite.uuid}") }.to_json
  end

  post '/connections/:uuid' do
    invite = InviteRepository.find(params[:uuid])
    accepting_user = session[:user]
    originating_user = UserRepository.find(invite.owner)

    accepting_user.connect originating_user
    UserRepository.save!(accepting_user, originating_user)
    "accepted"
  end

  def signed_in?
    !!session[:user]
  end

  ['get', 'post'].each do |method|
    send(method, '/auth/:name/callback') do
      auth = request.env['omniauth.auth']
      user_key = "#{auth[:provider]}_#{auth[:uid]}"
      nickname = auth[:info][:nickname]
      user = UserRepository.find_or_create(user_key, nickname)
      session[:user] = user
      session[:user_key] = user_key
      p auth
      redirect '/'
    end
  end
end
