class InviteRepository
  class << self
    def create(user)
      uuid = SecureRandom.uuid
      invite = Invite.new(:owner => user.uuid, :uuid => uuid)
      redis.set(uuid, invite.to_yaml)
      invite
    end

    def find(uuid)
      raw_invite = redis.get(uuid)
      YAML::load(raw_invite)
    end

    private
    def redis
      @redis ||= Redis.new
    end
  end
end
