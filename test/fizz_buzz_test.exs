defmodule FizzBuzzTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  doctest FizzBuzz

  def divisible?(n, divisor), do: rem(n, divisor) == 0

  property "all number not divisible by both 3 and 5 becomes itself" do
    check all n <- integer(), not divisible?(n, 3), not divisible?(n, 5) do
      assert FizzBuzz.fizz_buzz(n) == n
    end
  end

  property "all number divisible by 3 but not divisible by 5 becomes :fizz" do
    check all n_ <- integer(), n = n_ * 3, not divisible?(n, 5) do
      assert FizzBuzz.fizz_buzz(n) == :fizz
    end
  end

  property "all number divisible by 5 but not divisible by 3 becomes :buzz" do
    check all n_ <- integer(), n = n_ * 5, not divisible?(n, 3) do
      assert FizzBuzz.fizz_buzz(n) == :buzz
    end
  end

  property "all number divisible by both 3 and 5 becomes :fizz_buzz" do
    check all n_ <- integer(), n = n_ * 3 * 5 do
      assert FizzBuzz.fizz_buzz(n) == :fizz_buzz
    end
  end
end
