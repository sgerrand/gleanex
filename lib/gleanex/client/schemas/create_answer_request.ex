defmodule Gleanex.Client.CreateAnswerRequest do
  @moduledoc """
  Provides struct and type for a CreateAnswerRequest
  """

  @type t :: %__MODULE__{data: Gleanex.Client.AnswerCreationData.t()}

  defstruct [:data]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: {Gleanex.Client.AnswerCreationData, :t}]
  end
end
