class CreateDatabase < ActiveRecord::Migration
  def change
    create_table :clients do |t|
    end

    create_table :sites do |t|
      t.belongs_to :client
    end

    create_table :site_targets do |t|
      t.belongs_to :site
      t.belongs_to :target
    end

    create_table :targets do |t|
    end
  end
end
