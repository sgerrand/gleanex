defmodule Gleanex.Client.LabeledCountInfo do
  @moduledoc """
  Provides struct and type for a LabeledCountInfo
  """

  @type t :: %__MODULE__{countInfo: [Gleanex.Client.CountInfo.t()] | nil, label: String.t()}

  defstruct [:countInfo, :label]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [countInfo: [{Gleanex.Client.CountInfo, :t}], label: :string]
  end
end
