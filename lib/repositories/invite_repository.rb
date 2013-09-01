class InviteRepository
  class << self
    def create(user)
      uuid = SecureRandom.uuid
      invite = Invite.new(:owner => user.uuid, :key => uuid)
      redis.set(invite_key(uuid), invite.to_yaml)
      invite
    end

    def find(uuid)
      raw_invite = redis.get(invite_key(uuid))
      YAML::load(raw_invite)
    end

    private

    def invite_key(uuid)
      "invite_#{uuid}"
    end

    def redis
      @redis ||= Redis.new
    end
  end
end
