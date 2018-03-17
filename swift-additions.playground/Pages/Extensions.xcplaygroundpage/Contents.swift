import Foundation

// Array
extension Array {
    subscript(safe idx: Int) -> Element? {
        return idx < endIndex ? self[idx] : nil
    }
}

// Test
let testArray = [1, 2, 3]
testArray[safe: 1]
testArray[safe: 7]

// Sequence
extension Sequence where Element: Hashable {

    var frequencies: [Element: Int] {
        let frequencyPairs = self.map { ($0, 1) }
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }

    var uniques: [Element] {
        var seen: Set<Element> = []
        return filter { element in
            if seen.contains(element) {
                return false
            } else {
                seen.insert(element)
                return true
            }
        }
    }
}

// Test
"hello".frequencies
[1, 2, 3, 12, 1, 3, 4, 5, 6, 4, 6].uniques

// Collection
extension Collection {

    var isNotEmpty: Bool {
        return !isEmpty
    }
}

// Test
[1, 2, 3, 4].isNotEmpty

