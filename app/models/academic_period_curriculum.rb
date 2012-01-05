class AcademicPeriodCurriculum < ActiveRecord::Base
  belongs_to :academic_period
  belongs_to :curriculum
  has_many :academic_period_curriculum_lectures, :dependent => :destroy
  has_many :academic_period_curriculum_students, :dependent => :destroy
  
  validates :curriculum_id, :presence => true
  validates :academic_period_id, :presence => true
end