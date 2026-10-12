defmodule Gleanex.Platform.ProblemDetailError do
  @moduledoc """
  Provides struct and type for a ProblemDetailError
  """

  @type t :: %__MODULE__{code: String.t() | nil, detail: String.t(), pointer: String.t()}

  defstruct [:code, :detail, :pointer]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      code:
        {:enum,
         [
           "invalid_request",
           "missing_required_field",
           "invalid_parameter",
           "invalid_cursor",
           "expired_cursor",
           "invalid_filter",
           "invalid_datasource",
           "authentication_required",
           "token_expired",
           "insufficient_permissions",
           "spend_limit_exceeded",
           "resource_not_found",
           "method_not_allowed",
           "request_timeout",
           "request_too_large",
           "token_limit_exceeded",
           "conflict",
           "gone",
           "unprocessable_query",
           "tools_unauthorized",
           "rate_limit_exceeded",
           "internal_error",
           "service_unavailable"
         ]},
      detail: :string,
      pointer: :string
    ]
  end
end
