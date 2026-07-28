defmodule Gleanex.Client.StructuredLink do
  @moduledoc """
  Provides struct and type for a StructuredLink
  """

  @type t :: %__MODULE__{
          iconConfig: Gleanex.Client.IconConfig.t() | nil,
          name: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:iconConfig, :name, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [iconConfig: {Gleanex.Client.IconConfig, :t}, name: :string, url: :string]
  end
end
