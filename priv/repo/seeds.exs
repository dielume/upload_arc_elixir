# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Upload.Repo.insert!(%Upload.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Upload.Accounts
alias Upload.Accounts.User
alias Upload.Accounts.Attachment
alias Upload.Repo
import Ecto.Changeset
import Ecto.Query
import Ecto
user = Repo.get(User, 1)
attrs = %{"image" => %Plug.Upload{content_type: "application/pdf",
   filename: "IGP Impresión 3d mitad_a y mitad_b.pdf",
   path: "/var/folders/z2/51h_j79s4l36s68fyn849c5c0000gn/T//plug-1517/multipart-1517325541-159760741062966-4"},
  "name" => "lumecito"}
user |> User.changeset(attrs) |> Attachment.changeset(attrs)
|> Repo.update()






id = 8
user = Accounts.get_user!(id)
aso = assoc(user, :attachments)

{:ok, user} = Accounts.create_user(%{"name" => "diego"})
aso = user |> build_assoc(:attachments)
aso_changeset = aso |> Attachment.changeset(attrs)

user
|> build_assoc(:attachments)
|> Attachment.changeset(attrs)
|> Repo.insert()
