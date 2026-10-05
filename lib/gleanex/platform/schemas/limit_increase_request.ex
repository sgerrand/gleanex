defmodule Gleanex.Platform.LimitIncreaseRequest do
  @moduledoc """
  Provides struct and type for a LimitIncreaseRequest
  """

  @type t :: %__MODULE__{
          approved_increase_amount: String.t() | nil,
          business_justification: String.t() | nil,
          client_id: String.t(),
          created_at: DateTime.t(),
          entity_id: String.t(),
          entity_type: String.t(),
          period: String.t(),
          request_id: String.t(),
          requester_user_id: String.t(),
          resolution_note: String.t() | nil,
          resolution_target: String.t() | nil,
          resolution_target_id: String.t() | nil,
          resolved_by_user_id: String.t() | nil,
          scope: String.t() | nil,
          status: String.t(),
          updated_at: DateTime.t() | nil
        }

  defstruct [
    :approved_increase_amount,
    :business_justification,
    :client_id,
    :created_at,
    :entity_id,
    :entity_type,
    :period,
    :request_id,
    :requester_user_id,
    :resolution_note,
    :resolution_target,
    :resolution_target_id,
    :resolved_by_user_id,
    :scope,
    :status,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      approved_increase_amount: :string,
      business_justification: :string,
      client_id: :string,
      created_at: {:string, "date-time"},
      entity_id: :string,
      entity_type: {:enum, ["USER", "AGENT"]},
      period: :string,
      request_id: :string,
      requester_user_id: :string,
      resolution_note: :string,
      resolution_target: {:enum, ["USER", "ALL", "DEPARTMENT", "GROUP"]},
      resolution_target_id: :string,
      resolved_by_user_id: :string,
      scope: {:enum, ["PERIOD", "ONGOING"]},
      status: {:enum, ["PENDING", "APPROVED", "DENIED"]},
      updated_at: {:string, "date-time"}
    ]
  end
end
