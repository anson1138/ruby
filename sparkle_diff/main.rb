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
    @stack_filename = spec[:stack_filename]
    puts @stack_filename
  end

  def create_factory
    case @component
    when "cloudformation"
      CloudFormationTemplate.new(@stack_name)
    when "sparkle"
      SparkeFormationTemplate.new(@stack_filename)
    when "shared_entity"
      SparkleSharedEntity.new
    end
  end
end

class CloudFormationTemplate
  def initialize(stack_name)
    @sparkle_shared_entity = CloudTemplateFactory.new({:component => "shared_entity"}).create_factory
    @stack_name = stack_name
  end

  def get_template
    client = @sparkle_shared_entity.get_cloudformation_client
    resp = client.get_template({stack_name: @stack_name})
    content = resp.template_body
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
  def initialize(stack_filename)
    @sparkle_shared_entity = CloudTemplateFactory.new(:component => "shared_entity").create_factory
    @stack_filename = stack_filename
  end

  def get_template
    puts @stack_filename
    resp = `cat #{@stack_filename}`
    puts resp
    return resp
  end
end


def main
  stack_filename = ARGV[0]
  puts stack_filename
  cloudformation_template = SparkleDiffInteractor.new({
    :component => "cloudformation",
    :stack_name => "ansonECSTest2"
  }).write_template_to_file

  sparkleformation_template = SparkleDiffInteractor.new({
    :component => "sparkle",
    :stack_filename => stack_filename
  }).get_template
end

main

