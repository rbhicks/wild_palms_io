defmodule WildPalmsIoWeb.ContentItemLive.Index do
  use WildPalmsIoWeb, :live_view

  alias WildPalmsIo.Content
  alias WildPalmsIo.Content.ContentItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :content_items, Content.list_content_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Content item")
    |> assign(:content_item, Content.get_content_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Content item")
    |> assign(:content_item, %ContentItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Content items")
    |> assign(:content_item, nil)
  end

  @impl true
  def handle_info({WildPalmsIoWeb.ContentItemLive.FormComponent, {:saved, content_item}}, socket) do
    {:noreply, stream_insert(socket, :content_items, content_item)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_item = Content.get_content_item!(id)
    {:ok, _} = Content.delete_content_item(content_item)

    {:noreply, stream_delete(socket, :content_items, content_item)}
  end
end
