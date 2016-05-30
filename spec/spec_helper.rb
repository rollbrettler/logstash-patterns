require 'rubygems'
require 'grok-pure'
require 'rspec'

RSpec::Matchers.define :have_logstash_field do |field|
  chain :with_value do |value|
    @value= value
  end

  match do |grok_match|
    grok_captures = grok_match.captures()
    grok_field = grok_captures.keys.include?(field)
    if @value
      grok_captures[field].first.should == @value
    else
      grok_field.should equal true
    end
  end

  failure_message_for_should do |grok_match|
    if @value
      "\"#{field}\" isn't set to \"#{@value}\" in #{grok_match.captures()}"
    else
      "\"#{field}\" suffix not present in #{grok_match.captures().keys}"
    end
  end
end
