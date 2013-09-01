class User
  attr_reader :nickname

  def initialize(attrs = {})
    @nickname = attrs[:nickname]
  end
end
