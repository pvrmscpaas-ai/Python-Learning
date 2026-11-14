"""Examples and exercises for working with Python dates and times."""

from datetime import date, datetime, time, timedelta


def describe_datetime(moment: datetime) -> dict[str, int | float]:
    """Return the date/time fields requested in exercise 1."""
    return {
        "day": moment.day,
        "month": moment.month,
        "year": moment.year,
        "hour": moment.hour,
        "minute": moment.minute,
        "timestamp": moment.timestamp(),
    }


def format_datetime(moment: datetime) -> str:
    """Format a datetime as month/day/year, hour:minute:second."""
    return moment.strftime("%m/%d/%Y, %H:%M:%S")


def parse_date_string(value: str = "5 December, 2019") -> datetime:
    """Convert the exercise's date string into a datetime object."""
    return datetime.strptime(value, "%d %B, %Y")


def time_until_new_year(moment: datetime) -> timedelta:
    """Return the time from ``moment`` until the next New Year's Day."""
    next_new_year = datetime(moment.year + 1, 1, 1)
    return next_new_year - moment


def time_since_epoch(moment: datetime) -> timedelta:
    """Return the time elapsed since the Unix epoch."""
    epoch = datetime(1970, 1, 1)
    return moment - epoch


def demonstrate_datetime_types() -> None:
    """Show the date, time, and timedelta examples from the lesson."""
    print("date:", date(2020, 1, 1))
    print("time:", time(10, 30, 50, 200555))

    first_duration = timedelta(weeks=12, days=10, hours=4, seconds=20)
    second_duration = timedelta(days=7, hours=5, minutes=3, seconds=30)
    print("timedelta difference:", first_duration - second_duration)


def main() -> None:
    """Run the Day 16 examples and exercises."""
    now = datetime.now()
    details = describe_datetime(now)

    print("Current datetime:", now)
    print(
        "Day: {day}, Month: {month}, Year: {year}, "
        "Hour: {hour}, Minute: {minute}".format(**details)
    )
    print("Timestamp:", details["timestamp"])
    print("Formatted current date:", format_datetime(now))

    parsed_date = parse_date_string()
    print("Parsed date:", parsed_date)

    print("Time until next New Year:", time_until_new_year(now))
    print("Time since 1 January 1970:", time_since_epoch(now))

    demonstrate_datetime_types()


if __name__ == "__main__":
    main()
