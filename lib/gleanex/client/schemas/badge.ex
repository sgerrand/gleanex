defmodule Gleanex.Client.Badge do
  @moduledoc """
  Provides struct and type for a Badge
  """

  @type t :: %__MODULE__{
          displayName: String.t() | nil,
          iconConfig: Gleanex.Client.IconConfig.t() | nil,
          key: String.t() | nil,
          pinned: boolean | nil
        }

  defstruct [:displayName, :iconConfig, :key, :pinned]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      displayName: :string,
      iconConfig: {Gleanex.Client.IconConfig, :t},
      key: :string,
      pinned: :boolean
    ]
  end
end
