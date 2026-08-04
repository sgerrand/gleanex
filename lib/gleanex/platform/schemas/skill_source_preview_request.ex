defmodule Gleanex.Platform.SkillSourcePreviewRequest do
  @moduledoc """
  Provides struct and type for a SkillSourcePreviewRequest
  """

  @type t :: %__MODULE__{source_url: String.t(), stream: boolean | nil}

  defstruct [:source_url, :stream]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [source_url: :string, stream: :boolean]
  end
end
