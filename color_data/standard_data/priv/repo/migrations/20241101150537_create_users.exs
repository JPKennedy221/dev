defmodule StandardData.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :is_active, :boolean, default: false, null: false
      add :role, :string, default: "teacher", null: false
      timestamps(type: :utc_datetime)
    end

    create index(:users, [:id])
    create index(:users, [:email])
  end
end
