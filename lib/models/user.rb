class User
  attr_reader :nickname, :uuid, :connections

  def initialize(attrs = {})
    @nickname = attrs[:nickname]
    @uuid = attrs[:uuid]
    @connections = attrs[:connections] || []
  end

  def connect(other_user)
    return unless other_user.uuid != uuid
    return if connections.detect { |c| c[:uuid] == other_user.uuid }

    connections << { uuid: other_user.uuid, nickname: other_user.nickname }
    other_user.connections << { uuid: uuid, nickname: nickname }
  end
end
