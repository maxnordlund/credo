defmodule Credo.Service.SourceFileCodeOnlyTest do
  use Credo.TestHelper

  alias Credo.Service.SourceFileCodeOnly

  test "it should NOT report expected code" do
    expected = """
defmodule CredoSampleModule do
  def some_function(parameter1, parameter2) do
    parameter1 + "                 "
  end
end
"""
    source_file = """
defmodule CredoSampleModule do
  def some_function(parameter1, parameter2) do
    parameter1 + " this is a string" # this is a comment
  end
end
""" |> to_source_file("server_test1.exs")

    SourceFileCodeOnly.put(source_file.filename, expected)

    assert {:ok, expected} == source_file.filename |> SourceFileCodeOnly.get
  end

end
