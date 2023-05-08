defmodule WildPalmsIo.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WildPalmsIo.Content` context.
  """

  @doc """
  Generate a content_item.
  """
  def content_item_fixture(attrs \\ %{}) do
    {:ok, content_item} =
      attrs
      |> Enum.into(%{
        content: "some content",
        content_type: "some content_type",
        title: "some title"
      })
      |> WildPalmsIo.Content.create_content_item()

    content_item
  end
end
