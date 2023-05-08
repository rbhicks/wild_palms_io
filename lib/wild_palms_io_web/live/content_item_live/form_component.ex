defmodule WildPalmsIoWeb.ContentItemLive.FormComponent do
  use WildPalmsIoWeb, :live_component

  alias WildPalmsIo.Content

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage content_item records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="content_item-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:content]} type="text" label="Content" />
        <.input field={@form[:content_type]} type="text" label="Content type" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Content item</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{content_item: content_item} = assigns, socket) do
    changeset = Content.change_content_item(content_item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"content_item" => content_item_params}, socket) do
    changeset =
      socket.assigns.content_item
      |> Content.change_content_item(content_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"content_item" => content_item_params}, socket) do
    save_content_item(socket, socket.assigns.action, content_item_params)
  end

  defp save_content_item(socket, :edit, content_item_params) do
    case Content.update_content_item(socket.assigns.content_item, content_item_params) do
      {:ok, content_item} ->
        notify_parent({:saved, content_item})

        {:noreply,
         socket
         |> put_flash(:info, "Content item updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_content_item(socket, :new, content_item_params) do
    case Content.create_content_item(content_item_params) do
      {:ok, content_item} ->
        notify_parent({:saved, content_item})

        {:noreply,
         socket
         |> put_flash(:info, "Content item created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
