defmodule StudentPerformanceAnalytics.Repo.Migrations.CreateUnits do
  use Ecto.Migration

  def change do
    create table(:units) do
      add :title, :string, null: false

      timestamps()
    end
  end
end
