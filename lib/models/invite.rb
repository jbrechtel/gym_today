class Invite
  attr_reader :owner, :uuid
  def initialize(attrs = {})
    @owner = attrs[:owner]
    @uuid = attrs[:uuid]
  end

  def from?(user)
    owner == user.uuid
  end
end
