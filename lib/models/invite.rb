class Invite
  attr_reader :owner, :key
  def initialize(attrs = {})
    @owner = attrs[:owner]
    @key = attrs[:key]
  end
end
