defmodule Gleanex.Indexing.SocialNetworkDefinition do
  @moduledoc """
  Provides struct and type for a SocialNetworkDefinition
  """

  @type t :: %__MODULE__{
          name: String.t() | nil,
          profileName: String.t() | nil,
          profileUrl: String.t() | nil
        }

  defstruct [:name, :profileName, :profileUrl]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: :string, profileName: :string, profileUrl: :string]
  end
end
