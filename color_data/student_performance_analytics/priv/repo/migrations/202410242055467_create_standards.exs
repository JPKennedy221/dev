defmodule StudentPerformanceAnalytics.Repo.Migrations.CreateStandards do
  use Ecto.Migration

  def change do
    create table(:standards) do
      add :description, :text, null: false
      add :unit_id, references(:units, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:standards, [:unit_id])
  end
end
