import Foundation

// Variadic add

func add(numbers: Int...) -> Int {
    var result = 0

    for number in numbers {
        result += number
    }
    return result
}

print(add(numbers: 1, 2, 3, 4, 5, 6, 7))
