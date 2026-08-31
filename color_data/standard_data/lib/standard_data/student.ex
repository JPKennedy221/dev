defmodule StandardData.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :name, :string
    field :is_active, :boolean, default: false

    belongs_to :class, StandardData.Class
    has_many :assessments, StandardData.Assessment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:id, :name, :is_active])
    |> validate_required([:id, :name, :is_active])
  end
end
