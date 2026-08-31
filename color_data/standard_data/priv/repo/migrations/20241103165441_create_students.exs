defmodule StandardData.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :is_active, :boolean, default: false, null: false
      add :class_id, references(:classes, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:students, [:id])
    create index(:students, [:name])
  end
end
