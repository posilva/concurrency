defmodule WebtestTest do
  use ExUnit.Case
  doctest Webtest

  test "greets the world" do
    assert Webtest.hello() == :world
  end
end
