class Project < ApplicationRecord
  has_many :project_languages
  has_many :languages, through: :project_languages
  has_many :words
  
end
