class Project < ApplicationRecord
  has_many :project_languages
  has_many :languages, through: :project_languages
  has_many :words
  belongs_to :default_language, class_name: 'Language'
end
