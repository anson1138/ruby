class Interface
  def initialize
    @config
  end

  def get_config(env)
    @config = env.create_config
  end

  def output_config
    puts @config
  end
end

class Base
  def initialize
    @base = {
      :network => "_site_",
      :desired => "3",
      :min => "1",
      :max => "6"
    }
  end

  def get_base
    return @base
  end
end


class Production 
  def initialize
    @my_base = Base.new
  end

  def create_config
    base = Base.new
    config = base.get_base
    #config = @my_base.get_base
    config.merge!(
      :env => "prod",
      :desired => "4"
    )
  end
end


def main
  config = Interface.new
  config.get_config(Production.new)
  config.output_config
end

main
