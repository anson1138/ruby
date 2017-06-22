class Interface
  def get_config(env)
    config = env.create_config
    puts config
  end
end

class Base
  def initialize
    @base = {
      :desired => '3',
      :max => '6',
      :min => '2'
    }
  end
end

class ProductionConfig < Base
  def create_config
    @base.merge!(
      {
        :env => 'prod',
        :desired => '4'
      }
    )
  end
end

class StagingConfig < Base
  def create_config
    @base.merge!(
      {
        :env => 'stage'
      }
    )
  end
end

def get_elastic_config
  config = Interface.new
  config.get_config(ProductionConfig.new)
  config.get_config(StagingConfig.new)
end

def main
  get_elastic_config
end

main
