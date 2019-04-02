defmodule Ecto.Migration.RunnerTest do
  use ExUnit.Case

  import Ecto.Migration.Runner

  alias EctoSQL.TestRepo

  describe "repo_name/0" do
    test "runner repo_name" do
      {:ok, runner} = start_link(self(), TestRepo, :tenant_db, :forward, :up, %{level: false, sql: false})
      Process.put(:ecto_migration, %{runner: runner, prefix: nil})

      assert repo_name() == :tenant_db
      stop()
    end

    test "when runner is not started" do
      assert_raise RuntimeError, ~r/could not find migration runner process/, fn ->
        repo_name()
      end
    end
  end
end