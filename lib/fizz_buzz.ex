defmodule FizzBuzz do
  @moduledoc """
  Just another stupid fizz buzz 
  """

  def fizz_buzz(n) do
    case [rem(n, 3), rem(n, 5)] do
      [0, 0] -> :fizz_buzz
      [0, _] -> :fizz
      [_, 0] -> :buzz
      _ -> n
    end
  end
end
