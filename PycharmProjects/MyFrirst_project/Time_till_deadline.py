import datetime as dt
user_input = input("enter the goal date:\n")
input_list = user_input.split(":")
goal = input_list[0]
deadline = input_list[1]
print(input_list)
print(f"{goal}")
print(f" {deadline}")
#dt is module, datetime is definition list in the module, strptime is function of datetime definition list in module
deadline_input = dt.datetime.strptime(deadline, "%d.%m.%y")
print(type(deadline_input))
today_datetime = dt.datetime.today()

time_till = deadline_input - today_datetime
print(f"dear user time left for the deadline {time_till.days}")

#hours left

hour_till = int(time_till.total_seconds() / 60 / 60)
print(hour_till)