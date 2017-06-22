class Base
  def initialize
    @base = {
      :desired => "3",
      :max => "6",
      :min => "1"
    }
  end

  def output_config
    return @base
  end
end

class ConfigInterface
  def get_config(env)
    config = env.create_config
    puts config
  end
end

class Production
  def create_config
    base = Base.new
    config = base.output_config
    config.merge!(
      {
        :env => "prod",
        :desired => "500"
      }
    )
  end
end

class Staging

end

def create_elasticsearch_config
  interface = ConfigInterface.new
  interface.get_config(Production.new)
end

def main
  create_elasticsearch_config
end

main

#write func that are small < 20 lines => readability
#write func that are on same layer of abstraction - business logic, technical log => readability
#write func descriptive names => readability
#write func that do one thing (do something and get something are not in same func) => readbility
#write DRY func => less buggy, easier to maintain, only one place to make the change
#write func that tell a story => readability
#
#small
#abstraction
#descriptive
#one thing
#dry
#story
#
#sadods
#saddos
#small
#abstract
#descriptive
#dry
#one thing
#story
