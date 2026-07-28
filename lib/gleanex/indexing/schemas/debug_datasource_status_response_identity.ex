defmodule Gleanex.Indexing.DebugDatasourceStatusResponseIdentity do
  @moduledoc """
  Provides struct and type for a DebugDatasourceStatusResponseIdentity
  """

  @type t :: %__MODULE__{
          groups: Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponent.t() | nil,
          memberships: Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponent.t() | nil,
          processingHistory: [Gleanex.Indexing.ProcessingHistoryEvent.t()] | nil,
          users: Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponent.t() | nil
        }

  defstruct [:groups, :memberships, :processingHistory, :users]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      groups: {Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponent, :t},
      memberships: {Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponent, :t},
      processingHistory: [{Gleanex.Indexing.ProcessingHistoryEvent, :t}],
      users: {Gleanex.Indexing.DebugDatasourceStatusIdentityResponseComponent, :t}
    ]
  end
end
