class FreckleApi::Timer < FreckleApi::Model
  coerce_key :state, Symbol
  coerce_key :date, coerce_to_date
  coerce_key :user, FreckleApi::User
  coerce_key :project, FreckleApi::Project
end
