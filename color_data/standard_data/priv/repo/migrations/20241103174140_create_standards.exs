defmodule StandardData.Repo.Migrations.CreateStandards do
  use Ecto.Migration

  def change do
    create table(:standards) do
      add :name, :string
      add :unit_id, references(:units, on_delete: :delete_all), null: false
      timestamps(type: :utc_datetime)
    end
    create index(:standards, [:unit_id])
  end
end
