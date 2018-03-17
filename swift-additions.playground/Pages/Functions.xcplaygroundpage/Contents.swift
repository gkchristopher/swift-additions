import Foundation

// Variadic add

func add<T: BinaryInteger>(numbers: T...) -> T {
    var result: T = 0

    for number in numbers {
        result += number
    }
    return result
}

// Test
add(numbers: 1, 2, 3, 4, 5, 6, 7)
add(numbers: 5, -3, 1, -4)
add(numbers: 42)
