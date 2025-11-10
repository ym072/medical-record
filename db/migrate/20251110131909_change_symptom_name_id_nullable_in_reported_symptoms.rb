class ChangeSymptomNameIdNullableInReportedSymptoms < ActiveRecord::Migration[7.2]
  def change
    change_column_null :reported_symptoms, :symptom_name_id, true
  end
end
