class CreateDatabase < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name

      t.timestamps
    end

    create_table :sites do |t|
      t.belongs_to :client
      t.timestamps
    end

    create_table :site_targets do |t|
      t.belongs_to :site
      t.belongs_to :target

      t.timestamps
    end

    create_table :targets do |t|
      t.timestamps
    end
  end
end
