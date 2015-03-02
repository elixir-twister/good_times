defmodule GoodTimes.MetaTest do
  use ExUnit.Case
  import GoodTimes, only: [now: 0]

  defmodule A do
    @type year  :: integer
    @type month :: pos_integer
    @type day   :: pos_integer
    @type hour   :: non_neg_integer
    @type minute :: non_neg_integer
    @type second :: non_neg_integer
    @type datetime :: {{year, month, day}, {hour, minute, second}}

    require GoodTimes.Meta
    import GoodTimes.Meta

    define_time_unit_functions(:hundred, 100)
    define_time_unit_functions(:eight, 8, "an")
  end

  @a_datetime {{2015, 2, 27}, {18, 30, 45}}
  test "defines hundreds_after" do
    expected = {0, {0, 16, 40}}
    actual = difference @a_datetime, A.hundreds_after(10, @a_datetime)

    assert actual == expected
  end

  test "defines a_hundred_from_now" do
    expected = {0, {0, 1, 40}}
    actual = difference now, A.a_hundred_from_now

    assert actual == expected
  end

  test "defines a_hundred_ago" do
    expected = {-1, {23, 58, 20}}
    actual = difference now, A.a_hundred_ago

    assert actual == expected
  end

  test "defines an_eight_from_now" do
    expected = {0, {0, 0, 8}}
    actual = difference now, A.an_eight_from_now

    assert actual == expected
  end

  test "defines an_eight_ago" do
    expected = {-1, {23, 59, 52}}
    actual = difference now, A.an_eight_ago

    assert actual == expected
  end

  defp difference(t1, t2) do
    :calendar.time_difference t1, t2
  end
end
