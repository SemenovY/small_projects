"""
Example 1:

Input: date = "2019-01-09"
Output: 9
Explanation: Given date is the 9th day of the year in 2019.
Example 2:

Input: date = "2019-02-10"
Output: 41
"""


def day(date: str) -> int:
    list_year = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
    mount = int(date[5:7])
    day = int(date[-2:])
    res = 0
    if mount == 1:
        return day
    for i in range(mount - 1):
        res += list_year[i]
    if int(date[3]) // 4 != 0:
        return res + day + 1
    return res + day


print(day("2003-03-01"))
