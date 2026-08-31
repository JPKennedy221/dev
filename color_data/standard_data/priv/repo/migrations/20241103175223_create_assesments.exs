defmodule StandardData.Repo.Migrations.CreateAssesments do
  use Ecto.Migration

  def change do
    create table(:assesments) do
      add :student_id, references(:students, on_delete: :delete_all), null: false
      add :class_id, references(:classes, on_delete: :delete_all), null: false
      add :unit_id, references(:units, on_delete: :delete_all), null: false
      add :assessment_type_id, references(:assessment_types, on_delete: :delete_all), null: false
      add :standard_id, references(:standards, on_delete: :delete_all), null: false
      add :question_number, :integer
      add :score, :integer

      timestamps(type: :utc_datetime)
    end
#removed these on initial creation as assessments_student_id_index was throwing an error - revisit if needed
    #create index(:assessments, [:student_id])
    #create index(:assessments, [:class_id])
    #create index(:assessments, [:unit_id])
    #create index(:assessments, [:standard_id])
    #create index(:assessments, [:assessment_type_id])
    #create index(:assessments, [:id])
  end
end
