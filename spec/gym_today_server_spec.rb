require 'spec_helper'

describe GymTodayServer do
  include Rack::Test::Methods

  def app
    GymTodayServer
  end

  describe 'root' do
    it "redirects authenticated users" do
      current_session.rack_session['user'] = FactoryGirl.build(:user)
      get '/'
      last_response.should be_redirect
      last_response.location.should =~ /\/authenticated/
    end

    it "doesn't redirect unauthenticated users" do
      get '/'
      last_response.should be_ok
    end

  end

end
