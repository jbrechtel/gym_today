class Github
  class << self
    def api_key
      config['api_key']
    end

    def secret
      config['secret']
    end

    private

    def config
      @config ||= YAML.load(File.read(File.join(File.dirname(__FILE__), '..', 'secure', 'github.yaml')))
    end
  end
end
