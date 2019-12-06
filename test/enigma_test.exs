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
    assert %{1 => "a", 2 => "b", 3 => "c", 26 => "z", 27 => " "} = Enigma.character_set()
  end

  test "turns a list of tuples into a map, adjusting the index" do
    tuples = [{"a", 0}, {"b", 1}, {"c", 2}]
    assert %{1 => "a", 2 => "b", 3 => "c"} = Enigma.list_to_map(tuples)
  end

  test "assigns shifts to message characters" do
    message = String.codepoints("hello world")
    shifts = [2, 27, 73, 20]

    assert {"h", 2} == Enigma.get_shift_for_letter(message, 0, shifts)
    assert {"l", 20} == Enigma.get_shift_for_letter(message, 3, shifts)
    assert {"o", 2} == Enigma.get_shift_for_letter(message, 4, shifts)
    assert {" ", 27} == Enigma.get_shift_for_letter(message, 5, shifts)
    assert {"w", 73} == Enigma.get_shift_for_letter(message, 6, shifts)
  end

  test "encodes a letter" do
    assert "k" = Enigma.encode_letter({"h", 0})
    assert "e" = Enigma.encode_letter({"e", 1})
    assert "d" = Enigma.encode_letter({"l", 2})
    assert " " = Enigma.encode_letter({" ", 5})
  end

  test "encrypts a message" do
    assert "keder ohulw" == Enigma.encrypt_message("hello world")
  end
end
