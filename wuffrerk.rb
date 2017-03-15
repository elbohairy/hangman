require 'yaml'

class Nerd
  attr_accessor :hello

  def initialize
    @hello = 75
  end

  def save
    File.open(Time.new.strftime("%T.yml"), 'w') do |file|
      file.puts YAML::dump(self)
    end
  end
end

s = Nerd.new
s.save