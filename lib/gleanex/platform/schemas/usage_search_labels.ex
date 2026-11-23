defmodule Gleanex.Platform.UsageSearchLabels do
  @moduledoc """
  Provides struct and type for a UsageSearchLabels
  """

  @type t :: %__MODULE__{
          agent_id: map | nil,
          client_id: map | nil,
          feature: map | nil,
          model_id: map | nil,
          product: map | nil,
          user_id: map | nil
        }

  defstruct [:agent_id, :client_id, :feature, :model_id, :product, :user_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [agent_id: :map, client_id: :map, feature: :map, model_id: :map, product: :map, user_id: :map]
  end
end
