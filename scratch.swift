//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground!"
str = "Goodbye!"

var name:String = "Heeki Park"
name = "Josiah Park"

var unknown:String
unknown = "3"

var a:Int = 5
var b = 3 * a
var c:Double = 5 / 2
var d:Float = 5 / 2


var arr1 = [1, 2, 3, 4, 5]
arr1[0]
arr1.append(6)
arr1.removeAtIndex(2)
arr1

var dict = ["name": "Heeki", "age": 35, "gender": "M"]
dict["name"]
print(dict["name"]!)

dict["hairColor"] = "black"


var x = 44

if x % 2 == 0 {
    print("even")
} else {
    print("odd")
}


var random1 = rand()
var random2 = arc4random_uniform(10)

for (var i = 5; i <= 50; i+=5) {
    print(i)
}

var arr2 = [3, 6, 5, 9]

for (index, value) in arr2.enumerate() {
    print ("item \(index+1): \(value)")
}

for value in arr2 {
    print ("value: \(value)")
}

var i = 2
while (i <= 20) {
    print(i)
    i+=2
}


var arr3 = [3, 6, 5, 9]

var index = 0

while (index < arr3.count) {
    print(arr3[index])
    index++
}

