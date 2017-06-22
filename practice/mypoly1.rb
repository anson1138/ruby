class Base
  def initialize
    @config = {
      :asg => {
        :desired => '2',
        :maximum => '4',
        :minimum => '1'
      }
    }
  end
end

class Production < Base
  def gen_config
    myconfig = {
      :env => 'prod'
    }
    puts @config
    myconfig.merge!(@config)
    return myconfig
  end
end

class Staging < Base
  def gen_config
    myconfig = {
      :env => 'poc'
    }
    myconfig.merge!(@config)
    return myconfig
  end
end

def get_config(env)
  config = env.gen_config
  puts "Here is config: #{config}"
end


def main
  get_config(Production.new)
  get_config(Staging.new)
end

main


