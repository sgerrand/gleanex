defmodule Gleanex.Admin.ExternalSharingOptions do
  @moduledoc """
  Provides struct and type for a ExternalSharingOptions
  """

  @type t :: %__MODULE__{
          anonymousAccessEnabled: boolean | nil,
          anyoneInternalEnabled: boolean | nil,
          anyoneWithLinkEnabled: boolean | nil,
          domainAccessEnabled: boolean | nil,
          enabled: boolean | nil,
          threshold: integer | nil,
          thresholdEnabled: boolean | nil,
          userAccessEnabled: boolean | nil,
          userIds: [String.t()] | nil
        }

  defstruct [
    :anonymousAccessEnabled,
    :anyoneInternalEnabled,
    :anyoneWithLinkEnabled,
    :domainAccessEnabled,
    :enabled,
    :threshold,
    :thresholdEnabled,
    :userAccessEnabled,
    :userIds
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      anonymousAccessEnabled: :boolean,
      anyoneInternalEnabled: :boolean,
      anyoneWithLinkEnabled: :boolean,
      domainAccessEnabled: :boolean,
      enabled: :boolean,
      threshold: :integer,
      thresholdEnabled: :boolean,
      userAccessEnabled: :boolean,
      userIds: [:string]
    ]
  end
end
