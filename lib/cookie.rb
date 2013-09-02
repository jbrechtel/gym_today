class Cookie
  class << self
    def secret
      '1111111111111'
    end

    private

    def config
      @config ||= YAML.load(File.read(File.join(File.dirname(__FILE__), '..', 'secure', 'cookie.yaml')))
    end

  end
end
