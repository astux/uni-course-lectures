Rails.application.routes.draw do
  namespace :admin do
    resources :academic_periods do
      resources :academic_period_curriculums, :as => 'curriculums' do
        resources :academic_period_curriculum_students, :as => 'students'
      end
    end
  end
end
