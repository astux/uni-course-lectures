class AcademicPeriodsCurriculumsController < ApplicationController
  before_filter :load_academic_period
  
  def load_academic_period
    @academic_period = AcademicPeriod.find params[:academic_period_id]
  end
  
  def index
    @academic_period_curriculums = AcademicPeriodCurriculum.paginate :page => params[:page]
    
    respond_with @academic_periods_curriculums
  end
  
  def new
    @academic_period_curriculum = AcademicPeriodCurriculum.new
    
    respond_with @academic_period_curriculum
  end
  
  def create
    @academic_period_curriculum = AcademicPeriodCurriculum.new(params[:academic_period_curriculum])
    @academic_period_curriculum.academic_period_id = @academic_period.id
    
    @curriculum = @academic_period_curriculum.curriculum
    
    begin
      ActiveRecord::Base.transaction do
        if @curriculum && @curriculum.disciplines
          @curriculum.disciplines.each_with_index do |discipline, i|
            @lecture = Lecture.new
            @lecture.academic_period_id = @academic_period.id
            @lecture.discipline_id = discipline.id
            @lecture.professor_ids = params[:professor_ids]
            @lecture.code = @academic_period_curriculum.code + "#{discipline.code}"
            @lecture.save
            
            if @lecture.errors
              raise 'professor_ids'
            end
            
            @academic_period_curriculum_lecture = AcademicPeriodCurriculumLecture.new
            @academic_period_curriculum_lecture.lecture = @lecture
            
            @academic_period_curriculum.academic_period_curriculum_lectures << @academic_period_curriculum_lecture
          end
        end
        
        @academic_period_curriculum.save
      end
  
      respond_with @academic_period_curriculum, :location => {:action => 'show', :id => @academic_period_curriculum.id}
    rescue Exception => e
      if e.message == 'professor_ids'
        flash[:alert] = t 'activerecord.errors.models.academic_period_curriculum.professor_ids'
      else
        flash[:alert] = t 'activerecord.errors.models.academic_period_curriculum.professor_ids'
      end
      redirect_to({:action => 'new'})
    end
  end
  
  def show
    @academic_period_curriculum = AcademicPeriodCurriculum.find params[:id]
    @academic_period_curriculum_students = @academic_period_curriculum.academic_period_curriculum_students.paginate :page => params[:page]
    
    respond_with @academic_period_curriculum
  end
  
  def destroy
    @academic_period_curriculum = AcademicPeriodCurriculum.find(params[:id])
    
    begin
      @academic_period_curriculum.destroy
    rescue
      @academic_period_curriculum.errors.add(:curriculums, :cant_delete_still_has_students)
    end

    respond_with @academic_period_curriculum, :location => {:action => 'index'}
  end
end