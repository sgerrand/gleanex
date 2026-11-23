defmodule Gleanex.Platform.AgentSlackChannel do
  @moduledoc """
  Provides struct and type for a AgentSlackChannel
  """

  @type t :: %__MODULE__{
          allow_mentions_outside_channel_mappings: boolean | nil,
          channel_mappings: [Gleanex.Platform.AgentSlackChannelMapping.t()] | nil,
          engagement_filter_instructions: String.t() | nil,
          service_credential_id: String.t() | nil
        }

  defstruct [
    :allow_mentions_outside_channel_mappings,
    :channel_mappings,
    :engagement_filter_instructions,
    :service_credential_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allow_mentions_outside_channel_mappings: :boolean,
      channel_mappings: [{Gleanex.Platform.AgentSlackChannelMapping, :t}],
      engagement_filter_instructions: :string,
      service_credential_id: :string
    ]
  end
end
