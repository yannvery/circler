defmodule Circler.BuildTest do
  use ExUnit.Case
  alias Circler.{Project, Client, Build}

  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes/build")
    :ok
  end

  test "recent_builds" do
    use_cassette "example_build" do
      client = Client.new("4defadf434f2dd041fe0b363fd365e7ff545523d")

      {:ok, response} = Build.recent_builds(client)

      assert is_list(response) == true
    end
  end

  test "by_num" do
    use_cassette "example_by_num" do
      client = Client.new("4defadf434f2dd041fe0b363fd365e7ff545523d")
      project = Project.new("github", "codeclimate", "test-reporter")

      {:ok, response} = Build.by_num(client, project, "560")

      assert response["reponame"] == "test-reporter"
    end
  end

  test "artifacts" do
    use_cassette "example_artifacts" do
      client = Client.new("4defadf434f2dd041fe0b363fd365e7ff545523d")
      project = Project.new("github", "codeclimate", "test-reporter")

      {:ok, response} = Build.artifacts(client, project, "560")

      assert is_list(response) == true
    end
  end

end
