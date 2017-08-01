class AddLanguages < ActiveRecord::Migration[5.1]
  def up
    Language.create(name: 'En', description: 'DDESC elksjdl')
    Language.create(name: 'Ru', description: 'DDESC elksjdl')
    Language.create(name: 'Fr', description: 'DDESC elksjdl')
    Language.create(name: 'De', description: 'DDESC elksjdl')
  end

  def down
    Language.delete_all
  end
end
