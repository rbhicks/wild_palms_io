defmodule WildPalmsIo.Content.Storage do
  @storage_backend Application.fetch_env!(:my_app, :storage_backend)

  def store(file) do
    case @storage_backend do
      "local" ->
        store_local(file)
      "s3" ->
        store_s3(file)
      _ ->
        raise "Invalid storage backend configuration"
    end
  end

  defp store_local(file) do
    # Implement local storage logic
  end

  defp store_s3(file) do
    # Implement S3 storage logic
  end
end
