defmodule Gleanex.Platform.GetIdpGroupResponse do
  @moduledoc """
  Provides struct and type for a GetIdpGroupResponse
  """

  @type t :: %__MODULE__{idp_group: Gleanex.Platform.IdpGroup.t(), request_id: String.t()}

  defstruct [:idp_group, :request_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [idp_group: {Gleanex.Platform.IdpGroup, :t}, request_id: :string]
  end
end
