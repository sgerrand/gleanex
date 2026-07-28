defmodule Gleanex.Client.ConferenceData do
  @moduledoc """
  Provides struct and type for a ConferenceData
  """

  @type t :: %__MODULE__{provider: String.t(), source: String.t() | nil, uri: String.t()}

  defstruct [:provider, :source, :uri]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      provider: {:enum, ["ZOOM", "HANGOUTS"]},
      source: {:enum, ["NATIVE_CONFERENCE", "LOCATION", "DESCRIPTION"]},
      uri: :string
    ]
  end
end
