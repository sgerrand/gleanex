defmodule Gleanex.Client.FeedEntryUiConfig do
  @moduledoc """
  Provides struct and type for a FeedEntryUiConfig
  """

  @type t :: %__MODULE__{
          additionalFlags: Gleanex.Client.DisplayableListItemUIConfig.t() | nil,
          format: String.t() | nil
        }

  defstruct [:additionalFlags, :format]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [additionalFlags: {Gleanex.Client.DisplayableListItemUIConfig, :t}, format: {:const, "LIST"}]
  end
end
