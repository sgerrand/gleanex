defmodule Gleanex.Client.SocialNetwork do
  @moduledoc """
  Provides struct and type for a SocialNetwork
  """

  @type t :: %__MODULE__{name: String.t(), profileName: String.t() | nil, profileUrl: String.t()}

  defstruct [:name, :profileName, :profileUrl]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: :string, profileName: :string, profileUrl: {:string, "url"}]
  end
end
