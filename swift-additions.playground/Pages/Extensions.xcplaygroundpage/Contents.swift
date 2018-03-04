import Foundation

extension Array {
    subscript(safe idx: Int) -> Element? {
        return idx < endIndex ? self[idx] : nil
    }
}

let testArray = [1, 2, 3]
testArray[safe: 7]

extension Sequence where Element: Hashable {

    var frequencies: [Element: Int] {
        let frequencyPairs = self.map { ($0, 1) }
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }

    func uniques() -> [Element] {
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

let frequecies = "hello".frequencies
let onlyOne = frequecies.filter { $0.value == 1 }
print(onlyOne)

let uniques = [1, 2, 3, 12, 1, 3, 4, 5, 6, 4, 6].uniques()
