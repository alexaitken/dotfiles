require 'rubygems'
require 'wirble'
require 'awesome_print'
require 'whats_up'

Wirble.init
Wirble.colorize


AwesomePrint.pry!

def source_for(object, method_sym)
  if object.respond_to?(method_sym, true)
    method = object.method(method_sym)
  elsif object.is_a?(Module)
    method = object.instance_method(method_sym)
  end
  location = method.source_location
  `subl #{location[0]}:#{location[1]}` if location
  location
rescue
  nil
end
