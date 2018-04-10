class AddSubjectToPromotion < ActiveRecord::Migration[5.1]
  def change
    add_column :promotions, :subject, :string
  end
end
