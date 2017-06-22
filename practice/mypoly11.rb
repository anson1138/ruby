class Interface
  def get_config(env)
    env.create_config
  end
end

class Factory
  def get_factory(config)
    if config[:env] == "prod"
      env = Production.new
    end
  end
end

class Production
  def create_config
    base = Base.new
    config = base.create_config
    config.merge!({
      :env => "prod"
    })
  end
end

class Staging
  def create_config
    base = Base.new
    config = base.create_config
    config.merge!({
      :env => "staging"
    })
  end
end

class Base
  def create_config
    base = {
      :desired => "10"
    }
  end
end

def get_config
  my_factory = Factory.new
  factory = my_factory.get_factory({
    :env => "prod"
  })
  puts factory.class
  puts factory.create_config
  config = Interface.new
  puts config.get_config(Production.new)
  puts config.get_config(Staging.new)
end

def main
  get_config
end

main

#saddos
#small
#abatract
#dry
#descriptive
#do one thing
#tell a story
