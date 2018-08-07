defmodule LCDTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  def pow(n, exp) do
    :math.pow(n, exp) |> round
  end

  def integer_with_digit_count(digit_count) do
    integer(pow(10, digit_count - 1)..pow(10, digit_count))
  end

  def repeat_lcd(lcd, n) do
    for(_ <- 1..n, do: lcd) |> Enum.reduce(&LCD.concat/2)
  end

  def zip_chars({str_1, str_2}) do
    Enum.zip(String.graphemes(str_1), String.graphemes(str_2))
  end

  property "LCD is 3 lines high" do
    check all n <- positive_integer() do
      assert Enum.count(LCD.from_number(n)) == 3
    end
  end

  property "each digit is 3 colums wide" do
    check all n <- integer(0..9) do
      assert LCD.from_number(n) |> Enum.all?(&(String.length(&1) == 3))
    end
  end

  property "all digits are in seven segment form" do
    all_on = [
      " _ ",
      "|_|",
      "|_|"
    ]

    all_off = [
      "   ",
      "   ",
      "   "
    ]

    check all digit_count <- positive_integer(),
              n <- integer_with_digit_count(digit_count) do
      flattened_on_or_off =
        Enum.zip(repeat_lcd(all_on, digit_count), repeat_lcd(all_off, digit_count))
        |> Enum.map(&zip_chars/1)
        |> Enum.flat_map(& &1)

      flattened_lcd = LCD.from_number(n) |> Enum.flat_map(&String.graphemes/1)

      assert Enum.zip(flattened_lcd, flattened_on_or_off)
             |> Enum.all?(fn {segment, {on, off}} -> segment == on or segment == off end)
    end
  end

  property "total width is 3 times digit columns wide" do
    check all n <- positive_integer() do
      line_is_3_times_digit_wide? = fn line ->
        digit_count = Integer.digits(n) |> Enum.count()
        String.length(line) == digit_count * 3
      end

      assert LCD.from_number(n) |> Enum.all?(line_is_3_times_digit_wide?)
    end
  end

  property "single digit equals to its mapping" do
    check all n <- integer(0..9) do
      assert LCD.from_number(n) == LCD.from_digit(n)
    end
  end
end
