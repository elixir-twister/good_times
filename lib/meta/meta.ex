defmodule GoodTimes.Meta do
  def a_datetime, do: {{2015, 2, 27}, {18, 30, 45}}

  defmacro define_time_unit_functions(time_unit, seconds_per_time_unit, a \\ "a") do
    time_units = "#{time_unit}s" # TODO: pass in optional plural

    time_units_after = String.to_atom "#{time_units}_after"
    _a_time_unit_after = String.to_atom "#{a}_#{time_unit}_after"
    _time_units_before = String.to_atom "#{time_units}_before"
    _a_time_unit_before = String.to_atom "#{a}_#{time_unit}_before"
    _time_units_from_now = String.to_atom "#{time_units}_from_now"
    a_time_unit_from_now = String.to_atom "#{a}_#{time_unit}_from_now"
    _time_units_ago = String.to_atom "#{time_units}_ago"
    a_time_unit_ago = String.to_atom "#{a}_#{time_unit}_ago"

    quote do
      @doc """
      Returns the UTC date and time the specified #{unquote time_units} after the given datetime.

      ## Examples

          iex> 15 |> #{unquote time_units_after} #{inspect a_datetime}
          #{inspect GoodTimes.seconds_after(15 * unquote(seconds_per_time_unit), a_datetime)}
      """
      @spec unquote(time_units_after)(integer, datetime) :: datetime
      def unquote(time_units_after)(number, datetime) do
        GoodTimes.seconds_after(number * unquote(seconds_per_time_unit), datetime)
      end


      @doc """
      Returns the current UTC time #{unquote a} #{unquote time_unit} from now.

      ## Examples

          iex> #{unquote a_time_unit_from_now}
          #{inspect GoodTimes.seconds_after(unquote(seconds_per_time_unit), a_datetime)}
      """
      @spec unquote(a_time_unit_from_now)() :: datetime
      def unquote(a_time_unit_from_now)() do
        GoodTimes.seconds_from_now(unquote seconds_per_time_unit)
      end

      @doc """
      Returns the current UTC time #{unquote a} #{unquote time_unit} ago.

      ## Examples

          iex> #{unquote a_time_unit_ago}
          #{inspect GoodTimes.seconds_before(unquote(seconds_per_time_unit), a_datetime)}
      """
      @spec unquote(a_time_unit_ago)() :: datetime
      def unquote(a_time_unit_ago)() do
        GoodTimes.seconds_ago(unquote seconds_per_time_unit)
      end
    end
  end
end
