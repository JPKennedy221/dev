defmodule StandardData.Repo.Migrations.CreateAssessmentTypes do
  use Ecto.Migration

  def change do
    create table(:assessment_types) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    create index(:assessment_types, [:id])
    create index(:assessment_types, [:name])
  end
end
