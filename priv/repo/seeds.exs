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
