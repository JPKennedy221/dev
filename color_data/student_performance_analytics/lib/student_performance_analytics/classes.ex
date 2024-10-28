defmodule StudentPerformanceAnalytics.Classes do
  import Ecto.Query, warn: false
  alias StudentPerformanceAnalytics.Repo
  alias StudentPerformanceAnalytics.Classes.Class

  def list_active_classes do
    Repo.all(from c in Class, where: c.is_active == true)
  end

  def get_class!(id) do
    Repo.get!(Class, id)
  end

  def create_class(attrs \\ %{}) do
    %Class{}
    |> Class.changeset(attrs)
    |> Repo.insert()
  end

  def update_class(%Class{} = class, attrs) do
    class
    |> Class.changeset(attrs)
    |> Repo.update()
  end

  def delete_class(%Class{} = class) do
    Repo.delete(class)
  end

  def change_class(%Class{} = class) do
    Class.changeset(class, %{})
  end
end
