defmodule WildPalmsIo.Content.ContentItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "content_items" do
    field :content, :string
    field :content_type, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(content_item, attrs) do
    content_item
    |> cast(attrs, [:title, :content, :content_type])
    |> validate_required([:title, :content, :content_type])
  end
end
