defmodule WildPalmsIo.Repo.Migrations.CreateContentItems do
  use Ecto.Migration

  def change do
    create table(:content_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :content, :string
      add :content_type, :string

      timestamps()
    end
  end
end
