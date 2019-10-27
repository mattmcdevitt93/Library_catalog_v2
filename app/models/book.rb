class Book < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_full_name, against: [:Author_Last, :Author_first]
  pg_search_scope :search_by_year, against: :Copyright
  pg_search_scope :search_by_call_number, against: :Call_num
  pg_search_scope :search_by_title, against: :Title
  pg_search_scope :search_by_subject, against: [:Title, :Subtitle, :Subject, :Annotation]
end
