defmodule Upload.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Upload.Accounts.User


  schema "users" do
    field :name, :string
    has_many :attachments, Upload.Accounts.Attachment

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
