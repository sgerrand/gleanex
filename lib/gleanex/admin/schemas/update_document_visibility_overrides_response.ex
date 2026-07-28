defmodule Gleanex.Admin.UpdateDocumentVisibilityOverridesResponse do
  @moduledoc """
  Provides struct and type for a UpdateDocumentVisibilityOverridesResponse
  """

  @type t :: %__MODULE__{results: [Gleanex.Admin.DocumentVisibilityUpdateResult.t()] | nil}

  defstruct [:results]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [results: [{Gleanex.Admin.DocumentVisibilityUpdateResult, :t}]]
  end
end
