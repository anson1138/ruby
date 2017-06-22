class PolymorphicInterface
  def get_config(elastic_config)
    elastic_config.create_config
  end
end

class ESConfigFactory
  def get_env_factory(spec)
    case spec[:env]
    when "prod"
      return ESProdConfig.new
    when "base"
      return ESBaseConfig.new
    when "stage"
      return ESStageConfig.new
    else
      raise NotImplementedError
    end
  end
end

class ESConfigPlanner
  # send message of getting base config plus production config. who should receive it?
  def get_es_base_config
    es_config_factory = ESConfigFactory.new
    base_config_component = es_config_factory.get_env_factory(:env => "base")
    es_polymorphic_interface = PolymorphicInterface.new
    base_config = es_polymorphic_interface.get_config(base_config_component)
    return base_config
  end

  def get_es_env_config(env)
    es_config_factory = ESConfigFactory.new
    env_config_component = es_config_factory.get_env_factory(:env => env)
    es_polymorphic_interface = PolymorphicInterface.new
    env_config = es_polymorphic_interface.get_config(env_config_component)
    return env_config
  end

  def get_es_config(env)
    #base_config = get_es_base_config
    #env_config = get_es_env_config(env)
    #es_config = base_config.merge!(env_config)
    
    merge_config(
      :base => get_es_base_config,
      :env => get_es_env_config(env)
    )
    #es_config = merge_config(
    #  :base => get_es_base_config,
    #  :env => get_es_env_config(env)
    #)
    #return es_config
  end

  def merge_config(configs)
    base_config = configs[:base]
    env_config = configs[:env]
    config = base_config.merge!(env_config)
    return config
  end

end

class ESProdConfig
  def create_config
    {
      env: "prod"
    }
  end
end

class ESStageConfig
  def create_config
    {
      env: "stage"
    }
  end
end

class ESBaseConfig
  def create_config
    {
      desired: "3",
      max: "6",
      min: "2"
    }
  end
end

def get_es_config
  es_config_planner = ESConfigPlanner.new
  es_config = es_config_planner.get_es_config("stage")
  puts es_config
end

def main
  get_es_config
end

main


# Minimize exposure of methods in public interface and minimize knowledge of its neighbors => no object stands alone; to reuse any you need all,
# to change one thing you must change everything.
# Each object reveals as little about itself and knows as little about others as possible.
# focus on what class needs or wants, not how it should be implemented.
# focus on messages sent, not on classes.
# objects that know very little about other objects is better for greater reuse and less costly to change.
# i made mistake of making EsProdConfig know that it needs base config. why not decouple it.
# reveal little, know little => greater reuse, less costly to change; focus on what object wants not how it should be implemented; focus on messages sent, not on classes => helps to pinpoint which class or object should be responsible for handling the message.
# rlkl, wow noh
# saddos
#
# saddos 
# small functions => R
# same layer of abstraction (tech vs business, high vs low) => R
# descriptive => R
# DRY; don't repeat yourself => M
# do one thing => code reuse, M
# tell a story => R
