%w(rubygems wirble irb/completion).each { |library| require library }
ARGV.concat ["--readline"]

IRB.conf[:AUTO_INDENT]=true
IRB.conf[:PROMPT_MODE] = :INF_RUBY

Wirble.init
Wirble.colorize

 if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
   require 'logger'
   RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
 end

# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end
