defmodule Gleanex.Client.CollectionPinTarget do
  @moduledoc """
  Provides struct and type for a CollectionPinTarget
  """

  @type t :: %__MODULE__{category: String.t(), target: String.t() | nil, value: String.t() | nil}

  defstruct [:category, :target, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      category: {:enum, ["COMPANY_RESOURCE", "DEPARTMENT_RESOURCE", "TEAM_RESOURCE"]},
      target: {:enum, ["RESOURCE_CARD", "TEAM_PROFILE_PAGE"]},
      value: :string
    ]
  end
end
