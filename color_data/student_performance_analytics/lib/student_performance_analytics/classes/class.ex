defmodule StudentPerformanceAnalytics.Classes.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :name, :string
    field :year, :integer
    field :is_active, :boolean, default: true  # New field

    belongs_to :teacher, StudentPerformanceAnalytics.Accounts.Teacher
    has_many :students, StudentPerformanceAnalytics.Students.Student
    has_many :assessments, StudentPerformanceAnalytics.Assessments.Assessment

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:name, :year, :teacher_id, :is_active])  # Include `is_active`
    |> validate_required([:name, :year, :teacher_id])
  end
end
