defmodule Gleanex.Client.SummarizeResponse do
  @moduledoc """
  Provides struct and type for a SummarizeResponse
  """

  @type t :: %__MODULE__{
          error: Gleanex.Client.SummarizeResponseError.t() | nil,
          summary: Gleanex.Client.Summary.t() | nil,
          trackingToken: String.t() | nil
        }

  defstruct [:error, :summary, :trackingToken]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      error: {Gleanex.Client.SummarizeResponseError, :t},
      summary: {Gleanex.Client.Summary, :t},
      trackingToken: :string
    ]
  end
end
