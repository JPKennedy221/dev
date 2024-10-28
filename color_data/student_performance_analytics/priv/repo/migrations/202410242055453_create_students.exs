defmodule StudentPerformanceAnalytics.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string, null: false
      add :is_active, :boolean, default: true, null: false
      add :class_id, references(:classes, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:students, [:class_id])
  end
end
