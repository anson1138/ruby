#saddos
#rlkl wow noh
#small < 20 so R
#same layer of abstraction (tech vs business logic; high level vs low level) for R
#descriptive for R
#DRY for maintainability
#do one thing for M and R
#tell a story
#rlkl wow noh
#reveal little know little for Reuse, reduce cost of change
#focus on what object wants, not on how/implementation for Reuse, Reduce cost of change

class ESPlanner
  def initialize(env)
    @env = env
  end

  def create_es_config(component)
    component.create_config
  end

  def get_es_config
    base_component = get_es_factory("base")
    env_component = get_es_factory(@env)
    base_config = create_es_config(base_component)
    env_config = create_es_config(env_component)
    merge_es_config(:base => base_config, :env => env_config)
  end

  def get_es_factory(component)
    ESConfigFactory.new(:env => component).get_factory_component
  end

  def merge_es_config(components)
    base = components[:base]
    env = components[:env]
    base.merge!(env)
  end

  def output_es_config
    puts get_es_config
  end
end

class ESConfigFactory
  def initialize(spec)
    @env = spec[:env]
    #get_factory_component
  end

  def get_factory_component
    if @env == "prod"
      return ESConfigProd.new
    elsif @env == "stage"
      return ESConfigStage.new
    elsif @env == "base"
      return ESConfigBase.new
    end
  end
end

class ESConfigProd
  def create_config
    {
      :env => "prod"
    }
  end
end

class ESConfigStage
  def create_config
    {
      :env => "stage"
    }
  end

end

class ESConfigBase
  def create_config
    {
      :desired => "3"
    }
  end
end

def get_es_config
  config = ESPlanner.new("prod")
  config.output_es_config
end

def main
  get_es_config
end

main
