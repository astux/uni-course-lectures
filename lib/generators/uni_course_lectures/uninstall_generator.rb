require 'rails/generators/migration'

module UniCourseLectures
  module Generators
    class UninstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../uninstall/templates', __FILE__)
      desc "add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "migration.rb", "db/migrate/uni_course_lectures_uninstall.rb"
      end
    end
  end
end
