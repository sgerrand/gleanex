defmodule Gleanex.Client.Digest do
  @moduledoc """
  Provides struct and type for a Digest
  """

  @type t :: %__MODULE__{
          digestDate: String.t() | nil,
          podcastDuration: number | nil,
          podcastFileId: String.t() | nil,
          sections: [Gleanex.Client.DigestSection.t()] | nil
        }

  defstruct [:digestDate, :podcastDuration, :podcastFileId, :sections]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      digestDate: :string,
      podcastDuration: {:number, "float"},
      podcastFileId: :string,
      sections: [{Gleanex.Client.DigestSection, :t}]
    ]
  end
end
