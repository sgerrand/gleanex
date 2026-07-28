defmodule Gleanex.Client.DocumentInteractions do
  @moduledoc """
  Provides struct and type for a DocumentInteractions
  """

  @type t :: %__MODULE__{
          numComments: integer | nil,
          numReactions: integer | nil,
          reactions: [String.t()] | nil,
          reacts: [Gleanex.Client.Reaction.t()] | nil,
          shares: [Gleanex.Client.Share.t()] | nil,
          visitorCount: Gleanex.Client.CountInfo.t() | nil
        }

  defstruct [:numComments, :numReactions, :reactions, :reacts, :shares, :visitorCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      numComments: :integer,
      numReactions: :integer,
      reactions: [:string],
      reacts: [{Gleanex.Client.Reaction, :t}],
      shares: [{Gleanex.Client.Share, :t}],
      visitorCount: {Gleanex.Client.CountInfo, :t}
    ]
  end
end
