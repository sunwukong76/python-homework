#Your task is to create a Python script that analyzes the records to calculate each of the following:
#The total number of months included in the dataset.
#The net total amount of Profit/Losses over the entire period.
#The average of the changes in Profit/Losses over the entire period.
#The greatest increase in profits (date and amount) over the entire period.
#The greatest decrease in losses (date and amount) over the entire period.

# import data set
budget_data = {}

import csv

with open("budget_data.csv","r") as csv_file:
    csv_reader = csv.reader(csv_file)
    
    next(csv_reader)
    
    for row in csv_reader:
        budget_data[row[0]] = int(row[1])

# declare variables
total_months = 0
total_net = 0

# calculate totals
for key, value in budget_data.items():
    total_months  +=1
    total_net = total_net + int(value)

#declare variables for change parameters
total_change = 0
number = 0
number2 = list(budget_data.values())[0]
change = 0
minimum_key = ""
minimum_value = 0
maximum_key = ""
maximum_value = 0

#calculate daily change and ranks
for key, value in budget_data.items():
    number = value
    change = number - number2
    if change == 0:
        minimium_value = change
        minimum_key = key
    elif change < minimum_value:
        minimum_value = change
        minimum_key = key
    if change == 0:
        maximum_value = change
        maximum_key = key
    elif change > maximum_value:
        maximum_value = change
        maximum_key = key
    total_change = total_change + change
    number2 = value

avg_change = total_change/(total_months-1)

# print outputs
print(f"Financial Analysis")
print("-------------")
print(f"Total Months: {total_months}")
print(f"Total: ${total_net}")
print(f"Average Change: ${round(avg_change,2)}")
print(f"Greatest Increase: {maximum_key}: ${maximum_value}")
print(f"Greatest Decrease: {minimum_key}: ${minimum_value}")

output_path = "output.txt"

with open(output_path,"w")as file:
    file.write(f"Financial Analysis\n")
    file.write("-------------\n")
    file.write(f"Total Months: {total_months}\n")
    file.write(f"Total: ${total_net}\n")
    file.write(f"Average Change: ${round(avg_change,2)}\n")
    file.write(f"Greatest Increase: {maximum_key}: ${maximum_value}\n")
    file.write(f"Greatest Decrease: {minimum_key}: ${minimum_value}\n")