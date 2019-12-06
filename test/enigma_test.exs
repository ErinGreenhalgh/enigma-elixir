defmodule EnigmaTest do
  use ExUnit.Case
  doctest Enigma

  test "encrypts a message, given a key and a date" do
    assert Enigma.encrypt("hey", 02715, 040_895) == %{
             encryption: "keder ohulw",
             key: 02715,
             date: 040_895
           }
  end

  test "generates a character set with letters associated to a postion, including a space" do
    character_set = Enigma.character_set()
    assert %{"a" => 1, "b" => 2, "c" => 3, "z" => 26, " " => 27} = Enigma.character_set()
  end

  test "turns a list of tuples into a struct, adjusting the index" do
    tuples = [{"a", 0}, {"b", 1}, {"c", 2}]
    assert %{"a" => 1, "b" => 2, "c" => 3} = Enigma.list_to_map(tuples)
  end
end
