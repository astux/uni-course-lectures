class AcademicPeriodCurriculumStudent < ActiveRecord::Base
  belongs_to :academic_period_curriculum
  belongs_to :student
  
  before_destroy :remove_from_lectures
  
  def name
    student.name
  end
  
  private
    
    def remove_from_lectures
      for apcl in academic_period_curriculum.academic_period_curriculum_lectures
        @lecture_student = LectureStudent.find_by_student_id_and_lecture_id(student_id, apcl.lecture_id)
        @lecture_student.destroy
      end
    end
end