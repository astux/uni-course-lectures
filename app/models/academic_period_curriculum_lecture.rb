class AcademicPeriodCurriculumLecture < ActiveRecord::Base
  belongs_to :academic_period_curriculum
  belongs_to :lecture, :dependent => :destroy
end