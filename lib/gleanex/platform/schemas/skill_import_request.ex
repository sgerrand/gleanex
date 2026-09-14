defmodule Gleanex.Platform.SkillImportRequest do
  @moduledoc """
  Provides struct and type for a SkillImportRequest
  """

  @type t :: %__MODULE__{source_urls: [String.t()]}

  defstruct [:source_urls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [source_urls: [:string]]
  end
end
