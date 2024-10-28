defmodule StudentPerformanceAnalytics.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :name, :string
    field :is_active, :boolean, default: true

    belongs_to :class, StudentPerformanceAnalytics.Classes.Class
    has_many :assessments, StudentPerformanceAnalytics.Assessments.Assessment

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :is_active, :class_id])
    |> validate_required([:name, :class_id])
  end
end
