class UserRepository
  class << self
    def find_or_create(user_key, nickname)
      uuid = redis.get(user_key)
      if(uuid)
        YAML::load(redis.get(uuid))
      else
        uuid = SecureRandom.uuid
        user = User.new(nickname: nickname, uuid: uuid)
        redis.set(user_key, uuid)
        redis.set(uuid, user.to_yaml)
        user
      end
    end

    def find(uuid)
      YAML::load(redis.get(uuid))
    end

    def save!(*users)
      users.each { |u| redis.set(u.uuid, u.to_yaml) }
    end

    private

    def redis
      @redis ||= Redis.new
    end

  end
end
