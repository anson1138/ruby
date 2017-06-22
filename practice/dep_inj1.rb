class Factory
  def initialize(spec)
    @env = spec[:env]
    #get_factory
  end

  def get_factory
    if @env == "prod"
      return ESProdConfig.new
    end
  end
end

class ESProdConfig
  def create_config
    {
      :env => "prod"
    }
  end
end

def main
  factory = Factory.new(:env => "prod").get_factory
  puts factory
  #puts factory.get_factory

end

main


