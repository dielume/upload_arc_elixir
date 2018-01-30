defmodule Upload.Accounts.Attachment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Upload.Accounts.Attachment
  use Arc.Ecto.Schema

  schema "attachments" do
    field :image, UploadWeb.ImageUploader.Type, default: nil
    belongs_to :user, Upload.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Attachment{} = attachment, attrs) do
    attachment
    |> cast_attachments(attrs, [:image])
  end
end
