class CreateAcademicTerms < ActiveRecord::Migration[6.1]
  def change
    create_table :academic_terms do |t|
      t.string :academic_term
      t.integer :academic_term_code

      t.timestamps
    end
  end
end
