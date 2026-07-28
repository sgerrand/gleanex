defmodule Gleanex.Admin.UpdateDocumentVisibilityOverridesRequest do
  @moduledoc """
  Provides struct and type for a UpdateDocumentVisibilityOverridesRequest
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
