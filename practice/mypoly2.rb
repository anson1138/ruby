class Base
  def initialize
    @config = {
      :host => '_site_',
      :desired => '3',
      :max => '5'
    }
  end
end

class Production < Base
  def merge_config
    my_config = {
      :env => 'prod',
      :host => 'blah'
    }
    my_config.merge!(@config)
    return my_config
  end
end

class Staging < Base
  def merge_config
    my_config = {
      :env => 'poc'
    }
    my_config.merge!(@config)
    return my_config
  end
end

def get_config(env)
  config = env.merge_config
  puts config
end


def main
  get_config(Production.new)
  get_config(Staging.new)
end

main
