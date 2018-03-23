defmodule Circler.Client do
  @moduledoc """
  Client stores informations about: token and api endpoint.
  """

  defstruct token: "", endpoint: "https://circleci.com/api/v1.1/"

  @type t :: %__MODULE__{token: String.t(), endpoint: String.t()}

  @doc """
  Create a Client struct with circle token and enpoint api.
  ## Example

    iex> Circler.Client.new("username")

  More info at: https://circleci.com/docs/api/v1-reference/#summary
  """
  @spec new() :: t
  def new(), do: %__MODULE__{}

  @spec new(String.t()) :: t
  def new(token), do: %__MODULE__{token: token}

  @spec new(String.t(), String.t()) :: t
  def new(token, endpoint), do: %__MODULE__{token: token, endpoint: endpoint}
end
