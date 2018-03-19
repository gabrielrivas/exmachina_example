defmodule ExmachinaExampleTest do
  use ExUnit.Case
  doctest ExmachinaExample

  test "greets the world" do
    assert ExmachinaExample.hello() == :world
  end
end
