defmodule Gleanex.Platform.UsageSearchDimensions do
  @moduledoc """
  Provides struct and type for a UsageSearchDimensions
  """

  @type t :: %__MODULE__{
          agent_id: String.t() | nil,
          client_id: String.t() | nil,
          department_name: String.t() | nil,
          feature: String.t() | nil,
          group_id: String.t() | nil,
          model_id: String.t() | nil,
          product: String.t() | nil,
          user_id: String.t() | nil
        }

  defstruct [
    :agent_id,
    :client_id,
    :department_name,
    :feature,
    :group_id,
    :model_id,
    :product,
    :user_id
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      agent_id: {:union, [:string, :null]},
      client_id: {:union, [:string, :null]},
      department_name: {:union, [:string, :null]},
      feature: {:union, [:string, :null]},
      group_id: {:union, [:string, :null]},
      model_id: {:union, [:string, :null]},
      product: {:union, [:string, :null]},
      user_id: {:union, [:string, :null]}
    ]
  end
end
