defmodule Gleanex.Admin.SharingOptions do
  @moduledoc """
  Provides struct and type for a SharingOptions
  """

  @type t :: %__MODULE__{
          anonymousAccessEnabled: boolean | nil,
          anyoneInternalEnabled: boolean | nil,
          anyoneWithLinkEnabled: boolean | nil,
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
      enabled: :boolean,
      threshold: :integer,
      thresholdEnabled: :boolean,
      userAccessEnabled: :boolean,
      userIds: [:string]
    ]
  end
end
