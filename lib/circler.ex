defmodule Circler do
  alias Circler.Client

  @doc """
  Provides information about the signed in user.
  ## Example

    iex> client = Circler.Client.new("1234567890")
    iex> Circler.me(client)

  More info at: https://circleci.com/docs/api/v1-reference/#summary
  """
  @spec me(Client.t()) :: no_return()
  def me(client), do: get("me", client)

  @doc """
  Send get HHTP request to CircleCi api.
  ## Example

    iex> client = Circler.Client.new("1234567890")
    iex> Circler.get("me", client)

  More info at: https://circleci.com/docs/api/v1-reference/#summary
  """
  @spec get(String.t(), Client.t()) :: no_return()
  def get(path, client) do
    url = client |> url(path)
    headers = [Accept: "Application/json; Charset=utf-8"]

    :get
    |> HTTPoison.request(url, "", headers, [])
    |> handle_response
  end

  defp url(client, path) do
    client.endpoint <> path <> "?circle-token=" <> client.token
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  defp handle_response({_, %{status_code: _, body: body}}) do
    {:error, Poison.Parser.parse!(body)}
  end

  defp handle_response(response) do
    IO.inspect(response)
  end
end
