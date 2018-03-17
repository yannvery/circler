defmodule Circler.CirclerTest do
  use ExUnit.Case
  alias Circler

  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
    :ok
  end

  test "me" do
    use_cassette "example_me" do
      client = %{ token: "4defadf434f2dd041fe0b363fd365e7ff545523d",
                  endpoint: "https://circleci.com/api/v1.1/" }

      {:ok, response} = Circler.me(client)

      assert response["login"] == "CirclerHex"
    end
  end

  test "get" do
    use_cassette "example_me" do
      client = %{ token: "4defadf434f2dd041fe0b363fd365e7ff545523d",
                  endpoint: "https://circleci.com/api/v1.1/" }

      {:ok, response} = Circler.get("me", client)

      assert response["login"] == "CirclerHex"
    end
  end
end
