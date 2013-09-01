class User
  attr_reader :nickname, :key, :connections

  def initialize(attrs = {})
    @nickname = attrs[:nickname]
    @key = attrs[:key]
    @connections = attrs[:connections] || []
  end

  def connect(other_user)
    connections << { key: other_user.key, nickname: other_user.nickname }
    other_user.connections << { key: key, nickname: nickname }
  end
end
