class UserRepository
  class << self
    def redis
      @redis ||= Redis.new
    end

    def find_or_create(uid, nickname)
      raw_user = redis.get(user_key(uid))
      if(raw_user)
        YAML::load(raw_user)
      else
        user = User.new(:nickname => nickname, :key => user_key(uid))
        redis.set(user_key(uid), user.to_yaml)
        user
      end
    end

    def find(uid)
      YAML::load(redis.get(user_key(uid)))
    end

    def save!(*users)
      users.each { |u| redis.set(u.key, u.to_yaml) }
    end

    private

    def user_key(uid)
      "user_#{uid}"
    end
  end
end
