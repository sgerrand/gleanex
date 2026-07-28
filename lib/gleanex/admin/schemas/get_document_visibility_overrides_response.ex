defmodule Gleanex.Admin.GetDocumentVisibilityOverridesResponse do
  @moduledoc """
  Provides struct and type for a GetDocumentVisibilityOverridesResponse
  """

  @type t :: %__MODULE__{
          visibilityOverrides: [Gleanex.Admin.DocumentVisibilityOverride.t()] | nil
        }

  defstruct [:visibilityOverrides]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [visibilityOverrides: [{Gleanex.Admin.DocumentVisibilityOverride, :t}]]
  end
end
