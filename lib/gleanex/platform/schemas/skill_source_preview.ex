defmodule Gleanex.Platform.SkillSourcePreview do
  @moduledoc """
  Provides struct and type for a SkillSourcePreview
  """

  @type t :: %__MODULE__{
          commit_sha: String.t(),
          description: String.t(),
          display_name: String.t(),
          file_tree: [String.t()],
          files: [Gleanex.Platform.SkillSourcePreviewFile.t()],
          main_content: String.t(),
          source_url: String.t()
        }

  defstruct [
    :commit_sha,
    :description,
    :display_name,
    :file_tree,
    :files,
    :main_content,
    :source_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      commit_sha: :string,
      description: :string,
      display_name: :string,
      file_tree: [:string],
      files: [{Gleanex.Platform.SkillSourcePreviewFile, :t}],
      main_content: :string,
      source_url: :string
    ]
  end
end
