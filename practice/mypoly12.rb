class ElasticConfigFactory
  def get_factory_object(spec)
    if spec[:env] == "prod"
      return ESProductionConfig.new
    elsif spec[:env] == "stg"
      return ESStagingConfig.new
    elsif spec[:env] == "base"
      return ESBaseConfig.new
    else 
      puts "Invalid spec: #{spec[:env]}"
    end
  end
end

class PolymorphicInterface
  def get_config(env)
    env.create_config
  end
end

class ESBaseConfig
  def create_base
    config = {
      :desired => "30"
    }
  end
end

class ESProductionConfig
  def create_config
    base_config = get_factory("base")
    config = base_config.create_base
    config.merge!(
      {
        :env => "prod"
      }
    )
  end
end

class ESStagingConfig
  def create_config
    base_config = get_factory("base")
    config = base_config.create_base
    config.merge!(
      {
        :env => "staging"
      }
    )
  end
end

def get_factory(env)
  my_factory = ElasticConfigFactory.new
  env_config_object = my_factory.get_factory_object(:env => env)
  return env_config_object
end

def get_elasticsearch_config
  env = get_factory("prod")
  config = PolymorphicInterface.new
  puts config.get_config(env)

end

def main
  get_elasticsearch_config
end

main


#saddos
#small func => readable
#same layer of abstraction: business logic and tech logic separate, high level and low level separated => readable
#DRY don't repeat yourself => maintanable, less bugy
#descriptive func and variable names => readable
#do one thing: separate command and query => readable
#tell a story => readable
#
