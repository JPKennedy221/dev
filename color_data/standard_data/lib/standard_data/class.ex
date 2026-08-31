defmodule StandardData.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :title, :string
    field :year, :integer
    field :is_active, :boolean, default: false

    belongs_to :user, StandardData.User
    has_many :students, StandardData.Student
    has_many :assessments, StandardData.Assessment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:id, :title, :year, :id, :is_active])
    |> validate_required([:id, :title, :year, :id, :is_active])
  end
end
