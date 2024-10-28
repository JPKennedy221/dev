defmodule StudentPerformanceAnalytics.Repo.Migrations.CreateAssessmentTypes do
  use Ecto.Migration

  def change do
    create table(:assessment_types) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:assessment_types, [:name])
  end
end
