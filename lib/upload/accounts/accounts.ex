defmodule Upload.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto
  import Ecto.Query, warn: false
  alias Upload.Repo

  alias Upload.Accounts.User
  alias Upload.Accounts.Attachment

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end


  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(:attachments)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end


  def delete_user(%User{} = user) do
    Repo.delete(user)
  end


  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_attachment!(user) do
    user
    |> user_attachments
    |> Repo.one
  end

  def create_attachment(attrs \\ %{}, user) do
    user
    |> build_assoc(:attachments)
    |> Attachment.changeset(attrs)
    |> Repo.insert()
  end

  def update_attachment([%Attachment{} = attachment], attrs) do
    attachment
    |> Attachment.changeset(attrs)
    |> Repo.update()
  end

  defp user_attachments(user) do
    assoc(user, :attachments)
  end

end
