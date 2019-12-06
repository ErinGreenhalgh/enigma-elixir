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
    Enum.reduce(tuples, acc, fn item, acc -> Map.put(acc, elem(item, 0), elem(item, 1) + 1) end)
  end

  def encrypt_message(message) do
    # assign shifts to all characters in the message
    # modulo and do lookup
    "keder ohulw"
  end

  def get_shift_for_letter(message, letter_index, shifts) do
    length = Enum.count(shifts)
    shift_index = rem(letter_index, length)
    {Enum.at(message, letter_index), Enum.at(shifts, shift_index)}
  end

  def modulate_shifts(shifts) do
    Enum.map(shifts, &find_shift_number/1)
  end

  def find_shift_number(raw_shift) do
    if raw_shift == character_set_length() do
      raw_shift
    else
      rem(raw_shift, character_set_length())
    end
  end

  # def calculate_shifts do
  #   [3, 27, 73, 20]
  # end

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
