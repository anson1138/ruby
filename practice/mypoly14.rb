#saddos
#small,
#keep it same level of abstraction = 
#dry, descriptive, does one thing - command and query, tell a story

class ESConfigFactory
  def get_es_factory(spec)
    if spec[:env] == "prod"
      return ESConfigProd.new
    elsif spec[:env] == "stage"
      return ESConfigStage.new
    elsif spec[:env] == "base"
      return ESConfigBase.new
    else 
      raise NotImplementedError
    end
  end

end

class ESConfigInterface
  def get_config(env)
    env.create_config
  end
end

class ESConfigEntity
  def shared_factory(env)
    factory = ESConfigFactory.new
    factory.get_es_factory(env)
  end

end

class ESConfigProd
  def create_config
    {
      env: "prod"
    }.merge!(base_config)
  end

  def base_config
    base = ESConfigBase.new
    base.create_config
  end
end

class ESConfigStage
  def create_config
    {
      env: "stage"
    }.merge!(base_config)
  end

  def base_config
    base = ESConfigBase.new
    base.create_config
  end
end

class ESConfigBase
  def create_config
    {
      desired: "10"
    }
  end

end

def main
  #getFActoryobj
  factory = ESConfigFactory.new
  es_config_factory = factory.get_es_factory(:env => "stage")
  puts es_config_factory.class

  #use interface to construct config
  puts es_config_factory.create_config
end

main
