defmodule Gleanex.Platform.UnauthorizedAgentToolsProblem do
  @moduledoc """
  Provides struct and type for a UnauthorizedAgentToolsProblem
  """

  @type t :: %__MODULE__{
          authentication_suggestions: [Gleanex.Platform.AuthenticationSuggestion.t()] | nil,
          code: String.t() | nil,
          detail: String.t() | nil,
          documentation_url: String.t() | nil,
          errors: [Gleanex.Platform.ProblemDetailError.t()] | nil,
          request_id: String.t() | nil,
          status: integer | nil,
          title: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [
    :authentication_suggestions,
    :code,
    :detail,
    :documentation_url,
    :errors,
    :request_id,
    :status,
    :title,
    :type
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      authentication_suggestions: [{Gleanex.Platform.AuthenticationSuggestion, :t}],
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
      documentation_url: {:string, "uri"},
      errors: [{Gleanex.Platform.ProblemDetailError, :t}],
      request_id: :string,
      status: :integer,
      title: :string,
      type: {:string, "uri"}
    ]
  end
end
