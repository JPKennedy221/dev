defmodule StandardData.Repo.Migrations.CreateUnits do
  use Ecto.Migration

  def change do
    create table(:units) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    create index(:units, [:id])
    create index(:units, [:name])
  end
end
