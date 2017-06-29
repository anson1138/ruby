#saddos
#small func: same layer of abstraction: descriptive: do not repeat yourself: does one thing: tell a story
#rlkl wow noh
#reveal little, know little: focus on what object wants not on how/implementation
#
class ESConfigInteractor
  def initialize(attributes)
    @components = attributes[:components]
  end

  def get_factory(spec)
    component_factory = ESConfigFactory.new(spec).create_factory
    return component_factory
  end

  def get_all_configs
    all_es_configs = []
    component_factories = compile_all_component_factories
    component_factories.each do | es_config_component|
      all_es_configs.push(es_config_component.create_config)
    end
    return all_es_configs
  end

  def compile_all_component_factories
    component_factories = []
    @components.each do | component|
      component_factories.push(get_factory(:env => component))
    end
    return component_factories
  end

  def merge_all_configs(components)
    compile_all_configs(components).inject(:merge)
  end

  def compile_all_configs(components)
    all_es_configs = get_all_configs
  end
end

class ESConfigFactory
  def initialize(spec)
    @env = spec[:env]
  end

  def create_factory
    case @env
    when "base"
      return ESConfigBase.new
    when "prod"
      return ESConfigProd.new
    when "stage"
      return ESConfigStage.new
    end
  end
end

class ESConfigBase
  def create_config
    {
      :desired => "3"
    }
  end
end

class ESConfigProd
  def create_config
    {
      :env => "prod",
      :max => "77"
    }
  end
end

class ESConfigStage
  def create_config
    {
      :env => "stage",
      :desired => "1"
    }
  end
end

def get_elasticsearch_config(env)
  components = ["base", env]
  config = ESConfigInteractor.new({
    :components => components
  })
  puts config.merge_all_configs(components)
end

def main
  get_elasticsearch_config("prod")
end

main
