class Base
  def initialize
    @base = {
      :network => "_site_",
      :desired => "3",
      :min => "3",
      :max => "6"
    }
  end
end

class Production < Base
  def create_config
    @base.merge!(
      {
        :env => "prod",
        :cluster_name => "prod-es-application",
        :min => "5"
      }
    )
    puts @base
  end
end

class Staging < Base
  def create_config
    @base.merge!(
      {
        :env => "stg",
        :cluster_name => "poc-es-application",
        :min => "4"
      }
    )
    puts @base
  end
end

class Interface
  def create_config(env)
    env.create_config
  end
end


def main
  get_config
end

def get_config
  config = Interface.new
  config.create_config(Production.new)
  config.create_config(Staging.new)
end

main

# tell a story => improves readability
# keep business logic in one pile and construction of objects in separate pile via polymorphic interface => allows me to completely change function by swapping in entirely diff funcitonaly by diff env state.
# keep same layer of abstraction => improves readability
# keep func small
# func should do one thing. should do something or get something but not both.
