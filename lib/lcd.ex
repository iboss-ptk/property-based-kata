defmodule LCD do
  @empty ["", "", ""]

  def from_digit(digit) do
    %{
      0 => [
        " _ ",
        "| |",
        "|_|"
      ],
      1 => [
        "   ",
        "  |",
        "  |"
      ],
      2 => [
        " _ ",
        " _|",
        "|_ "
      ],
      3 => [
        " _ ",
        " _|",
        " _|"
      ],
      4 => [
        "   ",
        "|_|",
        "  |"
      ],
      5 => [
        " _ ",
        "|_ ",
        " _|"
      ],
      6 => [
        " _ ",
        "|_ ",
        "|_|"
      ],
      7 => [
        " _ ",
        "  |",
        "  |"
      ],
      8 => [
        " _ ",
        "|_|",
        "|_|"
      ],
      9 => [
        " _ ",
        "|_|",
        " _|"
      ]
    }[digit]
  end

  def from_number(number) do
    number
    |> Integer.digits()
    |> Enum.map(&from_digit/1)
    |> Enum.reduce(&concat/2)
  end

  def concat(lcd_1, lcd_2 \\ @empty) do
    Enum.zip(lcd_1, lcd_2)
    |> Enum.map(fn {a, b} -> a <> b end)
  end
end
