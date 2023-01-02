print("hello")
print('hello')
print(1)
print("hello " + str(5) + " hello")
#treat 50 as just string and used for concatinate, so we use f for formating
print(f"hello my name is {50*100} preethi")
#f stands for formating our text
#variables
var1 = 20*30*10
print(var1)
print(f"hello my name is {20*var1} preethi")
print(f"hello my name is {var1} preethi")
name="preethi"
print(f"hello my name is {var1} {name}")

#function -used to repeat a statments mutiple times using some logic or iterate statements of code using logic
#function is defined as keyword "def", block of code runs when called  & callinga func & excuting a fuction
#createing afunctiona nd using variblesin functions
def days_to_units():
    print(f"hello my name in function {var1} {name}")
#calling a function
days_to_units()

#Parameters or input providing for the function
#define input parameters
def days_to_units1(days_num):
    print(f"parameters in func {days_num} {var1} {name}")
days_to_units1(20)
days_to_units1(50)
# global and local varibles scope in function

#split function --used to split user input from string to list
user_input = f"hell, my, good, name, is, preethi"
x = user_input.split(", ")
print(type(x))
print(x)

