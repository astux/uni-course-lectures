$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "uni_course_lectures/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "uni_course_lectures"
  s.version     = UniCourseLectures::VERSION
  s.authors     = ["Bruno Ferreira Cavalcante"]
  s.email       = ["brunofcavalcante@gmail.com"]
  s.homepage    = "https://github.com/astux/uni-course-lectures"
  s.summary     = "Summary of UniCourseLectures."
  s.description = "Description of UniCourseLectures."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
