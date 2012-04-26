class UniCourseLecturesUninstall < ActiveRecord::Migration
   def change
     drop_table :academic_period_curriculums
     drop_table :academic_period_curriculum_lectures
     drop_table :academic_period_curriculum_students
  end
end