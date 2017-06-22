class Interface
  def get_config(classobj)
    classobj.create_config
  end
end

class Base
  def generate_base_config
    config = {
      :desired => "3",
      :max => "7",
      :min => "2"
    }
  end
end

class Production
  def create_config
    base_config = Base.new
    config = base_config.generate_base_config
    config.merge!(
      {
        :desired => "1000",
        :env => "prod"
      }
    )
  end
end

class Staging
  def create_config
    base_config = Base.new
    config = base_config.generate_base_config
    config.merge!(
      :max => "30000",
      :env => "stg"
    )
  end
end

def get_elasticsearch_config
  config = Interface.new
  puts config.get_config(Production.new)
  puts config.get_config(Staging.new)

end

def main
  get_elasticsearch_config
end

main

#SADDOS
#write functions that are:
#small so it's more readable
#same  layer of abstraction, high level separate from lower level, business logic sep from tech logic so readable.
#DRY - don't repeat yourself so reduce cost of change, less buggy, change in one place
#descriptive names so more readable.
#does one thing, command and query, separate doing something from getting something -> code reuse.
#tell a story so its readable.
