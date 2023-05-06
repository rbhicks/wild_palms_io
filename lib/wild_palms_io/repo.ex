defmodule WildPalmsIo.Repo do
  use Ecto.Repo,
    otp_app: :wild_palms_io,
    adapter: Ecto.Adapters.Postgres
end
