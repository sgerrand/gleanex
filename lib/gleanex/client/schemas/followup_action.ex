defmodule Gleanex.Client.FollowupAction do
  @moduledoc """
  Provides struct and type for a FollowupAction
  """

  @type t :: %__MODULE__{
          actionId: String.t() | nil,
          actionInstanceId: String.t() | nil,
          actionLabel: String.t() | nil,
          actionRunId: String.t() | nil,
          parameters: map | nil,
          recommendationText: String.t() | nil,
          userConfirmationRequired: boolean | nil
        }

  defstruct [
    :actionId,
    :actionInstanceId,
    :actionLabel,
    :actionRunId,
    :parameters,
    :recommendationText,
    :userConfirmationRequired
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actionId: :string,
      actionInstanceId: :string,
      actionLabel: :string,
      actionRunId: :string,
      parameters: :map,
      recommendationText: :string,
      userConfirmationRequired: :boolean
    ]
  end
end
