class Word < ApplicationRecord
  extend ActsAsTree::TreeView
  extend ActsAsTree::TreeWalker
  acts_as_tree
  belongs_to :project
  has_many :translations
  has_many :default_translations, class_name: 'Translation'

  def self.to_yaml(options = {})
    YAML.generate(options) do |yaml|
      yaml << column_values
      all.each do |word|
        yaml << word.attributes.values_at(*column_values)
      end
    end
  end
end
