class UniCourseLecturesInstall < ActiveRecord::Migration
   def change
     create_table :academic_period_curriculums do |t|
       t.integer :academic_period_id
       t.integer :curriculum_id
       t.string :code
       
       t.timestamps
     end
     
     create_table :academic_period_curriculum_lectures do |t|
       t.integer :academic_period_curriculum_id
       t.integer :lecture_id
       
       t.timestamps
     end
     
     create_table :academic_period_curriculum_students do |t|
       t.integer :academic_period_curriculum_id
       t.integer :student_id
       
       t.timestamps
     end
  end
end