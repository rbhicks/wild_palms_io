defmodule WildPalmsIo.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias WildPalmsIo.Repo

  alias WildPalmsIo.Content.ContentItem

  @doc """
  Returns the list of content_items.

  ## Examples

      iex> list_content_items()
      [%ContentItem{}, ...]

  """
  def list_content_items do
    Repo.all(ContentItem)
  end

  @doc """
  Gets a single content_item.

  Raises `Ecto.NoResultsError` if the Content item does not exist.

  ## Examples

      iex> get_content_item!(123)
      %ContentItem{}

      iex> get_content_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_content_item!(id), do: Repo.get!(ContentItem, id)

  @doc """
  Creates a content_item.

  ## Examples

      iex> create_content_item(%{field: value})
      {:ok, %ContentItem{}}

      iex> create_content_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content_item(attrs \\ %{}) do
    %ContentItem{}
    |> ContentItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a content_item.

  ## Examples

      iex> update_content_item(content_item, %{field: new_value})
      {:ok, %ContentItem{}}

      iex> update_content_item(content_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content_item(%ContentItem{} = content_item, attrs) do
    content_item
    |> ContentItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a content_item.

  ## Examples

      iex> delete_content_item(content_item)
      {:ok, %ContentItem{}}

      iex> delete_content_item(content_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content_item(%ContentItem{} = content_item) do
    Repo.delete(content_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content_item changes.

  ## Examples

      iex> change_content_item(content_item)
      %Ecto.Changeset{data: %ContentItem{}}

  """
  def change_content_item(%ContentItem{} = content_item, attrs \\ %{}) do
    ContentItem.changeset(content_item, attrs)
  end
end
