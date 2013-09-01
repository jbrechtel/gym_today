class Invite
  attr_reader :owner, :key
  def initialize(attrs = {})
    @owner = attrs[:owner]
    @key = attrs[:key]
  end

  def from?(user)
    puts "owner is: #{owner}"
    puts "user.uuid is: #{user.uuid}"
    owner == user.uuid
  end
end
