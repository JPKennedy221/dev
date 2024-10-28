defmodule StudentPerformanceAnalytics.Repo.Migrations.CreateAssessments do
  use Ecto.Migration

  def change do
    create table(:assessments) do
      add :student_id, references(:students, on_delete: :delete_all), null: false
      add :class_id, references(:classes, on_delete: :delete_all), null: false
      add :unit_id, references(:units, on_delete: :delete_all), null: false
      add :assessment_type_id, references(:assessment_types, on_delete: :delete_all), null: false
      add :question_number, :integer, null: false
      add :score, :integer, null: false

      timestamps()
    end

    create index(:assessments, [:student_id])
    create index(:assessments, [:class_id])
    create index(:assessments, [:unit_id])
    create index(:assessments, [:assessment_type_id])
  end
end
