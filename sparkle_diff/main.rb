require 'aws-sdk'
require 'json'
require 'pp'
# get cloudformation stack and output to file
#
# sfn print to file
#
# diff both files ignore white space
#


class SparkleDiffInteractor
  def initialize(context)
    @component = context[:component]
    @stack_name = context[:stack_name]
    @provisioner_component = get_component_factory
    @sparkle_shared_entity = get_shared_entity_factory

  end

  def get_template
    provisioner_template = @provisioner_component.get_template
  end

  def convert_template_to_pretty_json
    @sparkle_shared_entity.convert_to_pretty_json(get_template)
  end

  def write_template_to_file
    content = convert_template_to_pretty_json
    @sparkle_shared_entity.write_to_file({
      :path => "#{@component}_#{@stack_name}",
      :content => content
    })
  end

  def get_component_factory
    CloudTemplateFactory.new({
      :component => @component,
      :stack_name => @stack_name
    }).create_factory
  end

  def get_shared_entity_factory
    CloudTemplateFactory.new({
      :component => "shared_entity"
    }).create_factory
  end

end

class CloudTemplateFactory
  def initialize(spec)
    @component = spec[:component]
    @stack_name = spec[:stack_name]
  end

  def create_factory
    case @component
    when "cloudformation"
      CloudFormationTemplate.new(@stack_name)
    when "sparkle"
      SparkeFormationTemplate.new(@stack_name)
    when "shared_entity"
      SparkleSharedEntity.new
    end
  end
end

class CloudFormationTemplate
  def initialize(stack_name)
    #@sparkle_shared_entity = SparkleSharedEntity.new
    @sparkle_shared_entity = CloudTemplateFactory.new({:component => "shared_entity"}).create_factory
    puts @sparkle_shared_entity
    @stack_name = stack_name
  end

  def get_template
    client = @sparkle_shared_entity.get_cloudformation_client
    resp = client.get_template({stack_name: @stack_name})
    content = resp.template_body
    #content_pretty_json = @sparkle_shared_entity.convert_to_pretty_json(content)
    #write_template(content_pretty_json)
  end

  def write_template(content)
    file_attrib = {
      :path => "cloudformation_template_#{@stack_name}",
      :content => content
    }
    @sparkle_shared_entity.write_to_file(file_attrib)
  end
end

class SparkleSharedEntity
  def get_cloudformation_client
    client = Aws::CloudFormation::Client.new()
  end

  def convert_to_pretty_json(content)
    content_json = JSON.pretty_generate(JSON.parse(content))
    return content_json
  end

  def write_to_file(file_attrib)
    path = file_attrib[:path]
    content = file_attrib[:content]
    File.open(path, "w") do |f|
      f.write(content)
    end
  end
end

class SparkeFormationTemplate

  def get_template(stack_file)
    system "sfn print --file #{stack_file}"
    return output
  end
end


def main
  cloudformation_template = SparkleDiffInteractor.new({
    :component => "cloudformation",
    :stack_name => "ansonECSTest2"
  }).write_template_to_file
  #}).get_template
end

main

