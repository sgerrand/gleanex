defmodule Gleanex.Client.ErrorInfo do
  @moduledoc """
  Provides struct and type for a ErrorInfo
  """

  @type t :: %__MODULE__{
          badGmailToken: boolean | nil,
          badOutlookToken: boolean | nil,
          errorMessages: [Gleanex.Client.ErrorMessage.t()] | nil,
          federatedSearchRateLimitError: boolean | nil,
          invalidOperators: [Gleanex.Client.InvalidOperatorValueError.t()] | nil
        }

  defstruct [
    :badGmailToken,
    :badOutlookToken,
    :errorMessages,
    :federatedSearchRateLimitError,
    :invalidOperators
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      badGmailToken: :boolean,
      badOutlookToken: :boolean,
      errorMessages: [{Gleanex.Client.ErrorMessage, :t}],
      federatedSearchRateLimitError: :boolean,
      invalidOperators: [{Gleanex.Client.InvalidOperatorValueError, :t}]
    ]
  end
end
