#imports the argument variable
from sys import argv

#labels argument order for the powershell input
script, filename = argv

#when inputting a txt file, it will open it and show whats in it
txt = open(filename)

#this will print out "Here's your file" and display the contents of the txt file
print(f"Here's your file {filename}")
print(txt.read())

#prints "Type the filename again" + input your txt file again
print("Type the filename again")
file_again = input("> ")

#forces to open the content of the txt file
txt_again = open(file_again)

# prints the txt.file on the terminal
print(txt_again.read())