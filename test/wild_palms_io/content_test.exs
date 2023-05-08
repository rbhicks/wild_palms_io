defmodule WildPalmsIo.ContentTest do
  use WildPalmsIo.DataCase

  alias WildPalmsIo.Content

  describe "content_items" do
    alias WildPalmsIo.Content.ContentItem

    import WildPalmsIo.ContentFixtures

    @invalid_attrs %{content: nil, content_type: nil, title: nil}

    test "list_content_items/0 returns all content_items" do
      content_item = content_item_fixture()
      assert Content.list_content_items() == [content_item]
    end

    test "get_content_item!/1 returns the content_item with given id" do
      content_item = content_item_fixture()
      assert Content.get_content_item!(content_item.id) == content_item
    end

    test "create_content_item/1 with valid data creates a content_item" do
      valid_attrs = %{content: "some content", content_type: "some content_type", title: "some title"}

      assert {:ok, %ContentItem{} = content_item} = Content.create_content_item(valid_attrs)
      assert content_item.content == "some content"
      assert content_item.content_type == "some content_type"
      assert content_item.title == "some title"
    end

    test "create_content_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_content_item(@invalid_attrs)
    end

    test "update_content_item/2 with valid data updates the content_item" do
      content_item = content_item_fixture()
      update_attrs = %{content: "some updated content", content_type: "some updated content_type", title: "some updated title"}

      assert {:ok, %ContentItem{} = content_item} = Content.update_content_item(content_item, update_attrs)
      assert content_item.content == "some updated content"
      assert content_item.content_type == "some updated content_type"
      assert content_item.title == "some updated title"
    end

    test "update_content_item/2 with invalid data returns error changeset" do
      content_item = content_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_content_item(content_item, @invalid_attrs)
      assert content_item == Content.get_content_item!(content_item.id)
    end

    test "delete_content_item/1 deletes the content_item" do
      content_item = content_item_fixture()
      assert {:ok, %ContentItem{}} = Content.delete_content_item(content_item)
      assert_raise Ecto.NoResultsError, fn -> Content.get_content_item!(content_item.id) end
    end

    test "change_content_item/1 returns a content_item changeset" do
      content_item = content_item_fixture()
      assert %Ecto.Changeset{} = Content.change_content_item(content_item)
    end
  end
end
