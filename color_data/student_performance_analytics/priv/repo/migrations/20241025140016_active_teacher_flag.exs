defmodule StudentPerformanceAnalytics.Repo.Migrations.ActiveTeacherFlag do
  use Ecto.Migration

  def change do
    alter table(:teachers) do
      add :is_active, :boolean, default: true, null: false
    end
  end
end
