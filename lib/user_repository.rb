class UserRepository
  class << self
    def redis
      @redis ||= Redis.new
    end

    def find_or_create(user_key, nickname)
      raw_user = redis.get(user_key)
      if(raw_user)
        YAML::load(raw_user)
      else
        user = User.new(:nickname => nickname)
        redis.set(user_key, user.to_yaml)
        user
      end
    end
  end
end
