require 'rails'

module UniCourseLectures
  class Railtie < ::Rails::Railtie #:nodoc:
    config.after_initialize do
      Uni::Application.config.uni_broker.register(UniCourseLectures::UniPlugin.new)
    end
  end
end