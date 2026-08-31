defmodule StandardData.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password, :string
    field :email, :string
    field :is_active, :boolean, default: false
    field :role, :string, default: "teacher"
    timestamps(type: :utc_datetime)

    has_many :classes, StandardData.Class
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :name, :email, :password, :is_active, :role])
    |> validate_required([:id, :name, :email, :password, :is_active, :role])
  end
end
