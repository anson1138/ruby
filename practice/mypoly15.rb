def main
  #need an productionconfig objectfactory
  #use interface and pass productionconfig object and get config
end

class ESConfigFactory
  def create_esconfig(spec)
    if spec[:env] == "prod"
      return ESConfigProd.new
    elsif spec[:env] == "stage"
      return ESConfigStage.new
    else
      raise NotImplementedError
    end
  end
end

class ESInterface
  def get_es_config(component)
    component.create_es_hash
  end
end

class ESConfigProd
  def create_es_hash
    {
      env: "prod"
    }.merge(base_config)
  end

  def base_config
    config = ESConfigBase.new
    config.create_es_hash
  end
end

class ESConfigBase
  def create_es_hash
    {
      :desired => "3"
    }
  end
end


