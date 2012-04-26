require 'rails'
require_relative 'uni_plugin.rb'

module UniCourseLectures
  class Engine < ::Rails::Engine
    config.after_initialize do
      Uni::Application.config.uni_broker.register(UniCourseLectures::UniPlugin.new)
    end
  end
end
