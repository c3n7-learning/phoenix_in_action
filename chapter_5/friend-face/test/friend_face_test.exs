defmodule FriendFaceTest do
  use ExUnit.Case
  doctest FriendFace

  test "greets the world" do
    assert FriendFace.hello() == :world
  end
end
