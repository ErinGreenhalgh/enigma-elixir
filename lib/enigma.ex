defmodule Enigma do
  # optionally takes a key and date args
  # generate a random key if none given
  # use today's date if none given

  # def encryption(mesage) do
  #   %{
  #     encryption: message,
  #     key: random_key,
  #     date: format_date(today)
  #   }
  # end

  # def encryption(message, key) do
  #   %{
  #     encryption: encrypt(message),
  #     key: key,
  #     date: format_date(today)
  #   }
  # end

  def encrypt(message, key, date) do
    %{
      encryption: encrypt_message(message),
      key: key,
      date: date
    }
  end

  # memoize so this function is only ever run once
  def character_set do
    a_codepoint = List.first('a')
    z_codepoint = List.first('z')

    Enum.to_list(a_codepoint..z_codepoint)
    |> List.to_string()
    |> String.codepoints()
    |> List.insert_at(-1, " ")
    |> Enum.with_index()
    |> list_to_map()
  end

  # memoize
  def character_set_length do
    character_set()
    |> Map.keys()
    |> Enum.count()
  end

  def list_to_map(tuples) do
    acc = %{}
    Enum.reduce(tuples, acc, fn item, acc -> Map.put(acc, elem(item, 1) + 1, elem(item, 0)) end)
  end

  def encrypt_message(message) do
    String.codepoints(message)
    |> Enum.with_index()
    |> Enum.map(&encode_letter/1)
  end

  def encode_letter(letter_and_index) do
    # index of letter in message
    index = elem(letter_and_index, 1)
    letter = elem(letter_and_index, 0)

    character_index =
      character_set()
      |> Enum.find(fn {_, value} -> value == letter end)
      |> elem(0)

    {_, shift} = get_shift_for_letter(message_list(), index, shifts())
    encoded_position = rem(character_index + shift, character_set_length())
    # if character_index + shift == character_set_length.
    # return the character_index + shift
    require IEx
    IEx.pry()
    Map.get(character_set(), encoded_position)
  end

  def get_shift_for_letter(message, letter_index, shifts) do
    length = Enum.count(shifts)
    shift_index = rem(letter_index, length)
    {Enum.at(message, letter_index), Enum.at(shifts, shift_index)}
  end

  def shifts do
    [3, 27, 73, 20]
  end

  def message_list do
    String.codepoints("hello world")
  end

  # def calculate_keys do
  # end

  def calculate_offset(date) do
    :math.pow(date, 2)
    |> round
    |> to_string()
    |> String.slice(-4..-1)
  end
end

# calculate shifts from keys
# calculate offset
# encode letters based on shift and offset
