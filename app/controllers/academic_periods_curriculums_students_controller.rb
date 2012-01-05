class AcademicPeriodsCurriculumsStudentsController < ApplicationController
  before_filter :load_academic_period_curriculum
  
  def load_academic_period_curriculum
    @academic_period_curriculum = AcademicPeriodCurriculum.find params[:curriculum_id]
    @academic_period = AcademicPeriod.find params[:academic_period_id]
  end
  
  def new
    
  end
  
  def create
    begin
      ActiveRecord::Base.transaction do
        @academic_period_curriculum_lectures = @academic_period_curriculum.academic_period_curriculum_lectures
        
        for student_id in params[:student_ids]
          @academic_period_curriculum_student = AcademicPeriodCurriculumStudent.new
          @academic_period_curriculum_student.academic_period_curriculum_id = @academic_period_curriculum.id
          @academic_period_curriculum_student.student_id = student_id
          @academic_period_curriculum_student.save
        end
        
        for apcl in @academic_period_curriculum_lectures
          params[:student_ids].each do |student_id|
            @lecture_student = LectureStudent.new
            #@lecture_student.student_id = student_id
            @lecture_student.lecture = apcl.lecture
            @lecture_student.save
          end
        end
      end
    rescue
      flash[:alert] = t 'activerecord.errors.models.academic_period_curriculum_student.unknown'
    end
    redirect_to admin_academic_period_curriculum_path(@academic_period, @academic_period_curriculum)
  end
  
  def show
    @academic_period_curriculum_student = AcademicPeriodCurriculumStudent.find params[:id]
  end
  
  def destroy
    @academic_period_curriculum_student = AcademicPeriodCurriculumStudent.find(params[:id])
    
    begin
      @academic_period_curriculum_student.destroy
    rescue
      @academic_period_curriculum_student.errors.add(:curriculums, :cant_delete_still_has_students)
    end

    respond_with @academic_period_curriculum_student, :location => admin_academic_period_curriculum_path(@academic_period, @academic_period_curriculum)
  end
end