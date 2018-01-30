defmodule UploadWeb.ImageUploader do
  use Arc.Definition
  use Arc.Ecto.Definition
  # Include ecto support (requires package arc_ecto installed):
  # use Arc.Ecto.Definition

  @versions [:thumb, :original]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)



  #
  def __storage do
    Arc.Storage.Local
  end
  # To add a thumbnail version:
  # @versions [:original, :thumb]

  # Whitelist file extensions:
  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname |> String.downcase
    Enum.member?(@extension_whitelist, file_extension)
  end

  # def transform(:original, _), do: :noaction

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 100x100^ -gravity center -extent 100x100 -format png", :png}
    # {:convert, "-strip -thumbnail 100x100^ -gravity center -extent 100x100"}
    # {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  end

  # Override the persisted filenames:
  # def filename(version, _) do
  #   version
  # end

  # Override the storage directory:
  def storage_dir(version, {file, scope}) do
    "uploads/users/#{scope.user_id}"
  end



  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: Plug.MIME.path(file.file_name)]
  # end
end
