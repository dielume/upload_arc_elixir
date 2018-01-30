defmodule UploadWeb.UserController do
  use UploadWeb, :controller

  alias Upload.Accounts
  alias Upload.Accounts.User
  alias Ecto.Changeset

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    IO.inspect user_params
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        Accounts.create_attachment(%{}, user)
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    [nuevo] =  user.attachments
    IO.inspect nuevo
    render(conn, "show.html", user: user, user_image: nuevo)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)
    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        case Accounts.update_attachment(user.attachments, user_params)  do
          {:ok, attachment} ->
            conn
            |> put_flash(:info, "User updated successfully.")
            |> redirect(to: user_path(conn, :show, user))
          {:error, %Ecto.Changeset{} = changeset} ->
            IO.inspect  changeset
            render(conn, "edit.html", user: user, changeset: changeset)
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
