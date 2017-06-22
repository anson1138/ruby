class Base
  def initialize
    @base = {
      :env => "TBD",
      :min => "3"
    }
  end
end

class Interface
  def get_config(env)
    env.create_config
  end
end

class Production < Base
  def create_config
    @base.merge!(
      {
        :env => "prod",
        :stuff => "LK"
      }
    )
    puts @base
  end
end

class Staging < Base
  def create_config
    @base.merge!({
      :env => "poc",
      :desired => "1"
    })
    puts @base
  end
end

def get_config
  config = Interface.new
  config.get_config(Production.new)
  config.get_config(Staging.new)
end


def main
  get_config
end

main
