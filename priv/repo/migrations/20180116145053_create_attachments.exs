defmodule Upload.Repo.Migrations.CreateAttachments do
  use Ecto.Migration

  def change do
    create table(:attachments) do
      add :image, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:attachments, [:user_id])
  end
end
