defmodule Gleanex.Platform.RequestResponse do
  @moduledoc """
  Provides struct and type for a RequestResponse
  """

  @type t :: %__MODULE__{
          request: Gleanex.Platform.LimitIncreaseRequest.t(),
          request_id: String.t()
        }

  defstruct [:request, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [request: {Gleanex.Platform.LimitIncreaseRequest, :t}, request_id: :string]
  end
end
