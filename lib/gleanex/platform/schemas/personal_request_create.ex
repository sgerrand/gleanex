defmodule Gleanex.Platform.PersonalRequestCreate do
  @moduledoc """
  Provides struct and type for a PersonalRequestCreate
  """

  @type t :: %__MODULE__{business_justification: String.t() | nil, client_id: String.t()}

  defstruct [:business_justification, :client_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [business_justification: :string, client_id: :string]
  end
end
