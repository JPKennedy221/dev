defmodule StandardData.Assessment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assesments" do
    field :question_number, :integer
    field :score, :integer

    belongs_to :student, StandardData.Student
    belongs_to :class, StandardData.Class
    belongs_to :unit, StandardData.Unit
    belongs_to :assessment_type, StandardData.Assessment_Type
    belongs_to :standard, StandardData.Standard

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(assessment, attrs) do
    assessment
    |> cast(attrs, [:id, :question_number, :score, :student_id, :class_id, :unit_id, :assessment_type_id, :standard_id])
    |> validate_required([:id, :question_number, :score, :student_id, :class_id, :unit_id, :assessment_type_id, :standard_id])
    |> validate_inclusion(:score, 1..3)
  end
end
