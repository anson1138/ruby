require 'json'

class Interface
  def get_config(env)
    config = env.generate_config
    puts config.to_json
  end
end

class Base
  def initialize
    @config = {
      :network => {
        :host => "_site_"
      },
      :desired => '3',
      :max => '6',
      :min => '2'
    }
  end
end

class ElasticSearchProduction < Base
  def generate_config
    @config.merge!(
      {
        :env => 'prod',
        :desired => '4'
      }
    )
  end
end

class ElasticSearchStaging < Base
  def generate_config
    @config.merge!(
      {
        :env => 'poc',
        :desired => '2'
      }
    )
  end
end

def fetch_elasticsearch_config
  my_config = Interface.new
  my_config.get_config(ElasticSearchProduction.new)
  my_config.get_config(ElasticSearchStaging.new)
end

def main
  fetch_elasticsearch_config
end

main

#write func small < 20 lines -> readability
#write func on same layer of abstraction -> readability
#write func that do one thing. keep separate do something from get something -> code reusability and easier to name.
#write DRY func -> easier to change and less buggy code.
#write func names descriptive -> readability/maintanibility
#write func like a story
#separate business logic from constructing objects -> gives you flexibility to swap diff objects based on state or env w/ little cost of change. easier to test as well as your business logic is not tightly coupled to constructing objects.
#


