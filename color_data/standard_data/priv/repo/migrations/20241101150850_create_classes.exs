defmodule StandardData.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :title, :string
      add :year, :integer
      add :is_active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
    create index(:classes, [:id])
    create index(:classes, [:title])
  end
end
