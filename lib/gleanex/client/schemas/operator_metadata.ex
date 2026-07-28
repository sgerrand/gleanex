defmodule Gleanex.Client.OperatorMetadata do
  @moduledoc """
  Provides struct and type for a OperatorMetadata
  """

  @type t :: %__MODULE__{
          displayValue: String.t() | nil,
          helpText: String.t() | nil,
          isCustom: boolean | nil,
          name: String.t(),
          operatorType: String.t() | nil,
          scopes: [Gleanex.Client.OperatorScope.t()] | nil,
          value: String.t() | nil
        }

  defstruct [:displayValue, :helpText, :isCustom, :name, :operatorType, :scopes, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      displayValue: :string,
      helpText: :string,
      isCustom: :boolean,
      name: :string,
      operatorType: {:enum, ["TEXT", "DOUBLE", "DATE", "USER"]},
      scopes: [{Gleanex.Client.OperatorScope, :t}],
      value: :string
    ]
  end
end
