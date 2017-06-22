#saddos
#small func
#same layer of abstraction - business logic sep from tech logic, high level sep from low level
#descriptive names
#dry don't repeat yourself
#do one thing - command and query - do something sep from get something
#tell a story

class ElasticConfigFactory
  def get_elastic_config_obj(spec)
    if spec[:env] == "prod"
      return ElasticConfigProd.new
    elsif spec[:env] == "stage"
      return ElasticConfigStage.new
    elsif spec[:env] == "base"
      return ElasticConfigBase.new
    else
      puts "Invalid spec given: #{spec[:env]}"
    end
  end
end

class ElasticConfigPolymorphicInterface
  def get_elastic_config(env)
    env.create_elastic_config
  end
end

class ElasticConfigProd
  def create_elastic_config
    base_config = SharedBusinessLogicEntity.new
    config = base_config.get_elastic_base
    config.merge!(
      :env => "prod"
    )
    return config
  end
end

class ElasticConfigStage
  def create_elastic_config
    base_config = SharedBusinessLogicEntity.new
    config = base_config.get_elastic_base
    config.merge!(
      {
        :env => "stage"
      }
    )
  end
end

class ElasticConfigBase
  def create_elastic_config
    config = {
      :desired => "3",
      :max => "60",
      :min => "1"
    }
    return config
  end
end

class SharedBusinessLogicEntity
  def get_elastic_base
    facade_elastic_config("base")
  end

  def facade_elastic_config(env)
    es_config_obj = get_elastic_obj(env)
    get_elastic_config(es_config_obj)
  end

  def get_elastic_obj(env)
    es_factory_obj = ElasticConfigFactory.new
    es_config_obj = es_factory_obj.get_elastic_config_obj(:env => env)
    return es_config_obj
  end

  def get_elastic_config(es_config_obj)
    interface = ElasticConfigPolymorphicInterface.new
    interface.get_elastic_config(es_config_obj)
  end
end

def main
  get_elastic_config("prod")
  get_elastic_config("stage")
end

def get_elastic_config(env)
  config = SharedBusinessLogicEntity.new
  puts config.facade_elastic_config(env)
end

main
