defmodule Gleanex.Client.CustomFieldData do
  @moduledoc """
  Provides struct and type for a CustomFieldData
  """

  @type t :: %__MODULE__{
          displayable: boolean,
          label: String.t(),
          values: [
            Gleanex.Client.CustomFieldValueHyperlink.t()
            | Gleanex.Client.CustomFieldValuePerson.t()
            | Gleanex.Client.CustomFieldValueStr.t()
          ]
        }

  defstruct [:displayable, :label, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      displayable: :boolean,
      label: :string,
      values: [
        union: [
          {Gleanex.Client.CustomFieldValueHyperlink, :t},
          {Gleanex.Client.CustomFieldValuePerson, :t},
          {Gleanex.Client.CustomFieldValueStr, :t}
        ]
      ]
    ]
  end
end
