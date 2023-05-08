defmodule WildPalmsIoWeb.ContentItemLiveTest do
  use WildPalmsIoWeb.ConnCase

  import Phoenix.LiveViewTest
  import WildPalmsIo.ContentFixtures

  @create_attrs %{content: "some content", content_type: "some content_type", title: "some title"}
  @update_attrs %{content: "some updated content", content_type: "some updated content_type", title: "some updated title"}
  @invalid_attrs %{content: nil, content_type: nil, title: nil}

  defp create_content_item(_) do
    content_item = content_item_fixture()
    %{content_item: content_item}
  end

  describe "Index" do
    setup [:create_content_item]

    test "lists all content_items", %{conn: conn, content_item: content_item} do
      {:ok, _index_live, html} = live(conn, ~p"/content_items")

      assert html =~ "Listing Content items"
      assert html =~ content_item.content
    end

    test "saves new content_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/content_items")

      assert index_live |> element("a", "New Content item") |> render_click() =~
               "New Content item"

      assert_patch(index_live, ~p"/content_items/new")

      assert index_live
             |> form("#content_item-form", content_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#content_item-form", content_item: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/content_items")

      html = render(index_live)
      assert html =~ "Content item created successfully"
      assert html =~ "some content"
    end

    test "updates content_item in listing", %{conn: conn, content_item: content_item} do
      {:ok, index_live, _html} = live(conn, ~p"/content_items")

      assert index_live |> element("#content_items-#{content_item.id} a", "Edit") |> render_click() =~
               "Edit Content item"

      assert_patch(index_live, ~p"/content_items/#{content_item}/edit")

      assert index_live
             |> form("#content_item-form", content_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#content_item-form", content_item: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/content_items")

      html = render(index_live)
      assert html =~ "Content item updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes content_item in listing", %{conn: conn, content_item: content_item} do
      {:ok, index_live, _html} = live(conn, ~p"/content_items")

      assert index_live |> element("#content_items-#{content_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#content_items-#{content_item.id}")
    end
  end

  describe "Show" do
    setup [:create_content_item]

    test "displays content_item", %{conn: conn, content_item: content_item} do
      {:ok, _show_live, html} = live(conn, ~p"/content_items/#{content_item}")

      assert html =~ "Show Content item"
      assert html =~ content_item.content
    end

    test "updates content_item within modal", %{conn: conn, content_item: content_item} do
      {:ok, show_live, _html} = live(conn, ~p"/content_items/#{content_item}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Content item"

      assert_patch(show_live, ~p"/content_items/#{content_item}/show/edit")

      assert show_live
             |> form("#content_item-form", content_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#content_item-form", content_item: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/content_items/#{content_item}")

      html = render(show_live)
      assert html =~ "Content item updated successfully"
      assert html =~ "some updated content"
    end
  end
end
