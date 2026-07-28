defmodule Gleanex.Client.SearchProviderInfo do
  @moduledoc """
  Provides struct and type for a SearchProviderInfo
  """

  @type t :: %__MODULE__{
          logoUrl: String.t() | nil,
          name: String.t() | nil,
          searchLinkUrlTemplate: String.t() | nil
        }

  defstruct [:logoUrl, :name, :searchLinkUrlTemplate]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [logoUrl: :string, name: :string, searchLinkUrlTemplate: :string]
  end
end
