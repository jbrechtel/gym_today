require 'spec_helper'

describe User do
  describe "connecting with other users" do
    it "should add a connection with the other user" do
      u = User.new(uuid: 'def', nickname: 'james')
      other = User.new(:uuid => 'abc', :nickname => 'joe')
      u.connect other
      u.connections.first[:uuid].should == 'abc'
      u.connections.first[:nickname].should == 'joe'
    end

    it "should add a connection inside the other user" do
      u = User.new(uuid: 'def', nickname: 'james')
      other = User.new(:uuid => 'abc', :nickname => 'joe')
      u.connect other
      other.connections.first[:uuid].should == 'def'
      other.connections.first[:nickname].should == 'james'
    end

    it "should not add a connection to itself" do
      u = User.new(uuid: 'def', nickname: 'james')
      u.connect u

      u.connections.should be_empty
    end

    it "should not add a second connection on self to the same user" do
      u = User.new(uuid: 'def', nickname: 'james')
      other = User.new(:uuid => 'abc', :nickname => 'joe')
      u.connect other
      u.connect other

      u.connections.count.should == 1
    end

    it "should not add a second connection on another user to self" do
      u = User.new(uuid: 'def', nickname: 'james')
      other = User.new(:uuid => 'abc', :nickname => 'joe')
      u.connect other
      u.connect other

      other.connections.count.should == 1
    end
  end
end
