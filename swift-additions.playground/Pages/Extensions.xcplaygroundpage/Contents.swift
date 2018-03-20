import Foundation

// Collection
extension Collection {
    /// Finds next element satisfying the predicate and wraps around the end of collection
    func elementAfter(_ element: Element, where predicate: (Element, Element) -> Bool) -> Element? {
        guard let index = index(where: { predicate(element, $0) }) else {
            return first
        }

        return self[wraparoundIndex(after: index)]
    }

    func wraparoundIndex(after idx: Index) -> Index {
        let nextIndex = index(after: idx)
        return nextIndex == self.endIndex ? self.startIndex : nextIndex
    }
}

// Test
let coll = AnyCollection(["a", "b", "c", "d"])
coll.elementAfter("a", where: ==)
coll.elementAfter("c", where: ==)
coll.elementAfter("c", where: >=)
coll.elementAfter("z", where: ==)

struct CyclicSequence<Base: Sequence>: Sequence {
    let base: Base

    init(base: Base) {
        self.base = base
    }

    func makeIterator() -> CyclicIterator<Base> {
        return CyclicIterator(base: base)
    }
}

struct CyclicIterator<Base: Sequence>: IteratorProtocol {
    typealias Element = Base.Element

    let base: Base
    var currentIterator: Base.Iterator

    init(base: Base) {
        self.base = base
        self.currentIterator = base.makeIterator()
    }

    mutating func next() -> Base.Element? {
        if let next = currentIterator.next() {
            return next
        }
        currentIterator = base.makeIterator()
        if let next = currentIterator.next() {
            return next
        }
        return nil
    }
}

extension Sequence {
    func cycle() -> CyclicSequence<Self> {
        return CyclicSequence(base: self)
    }
}

// Data
extension Data {
    var hexString: String {
        return self.map({ return String(format: "%02hhx", $0) }).joined()
    }
}

let data = Data(bytes: [0, 2, 3, 4, 255])
data.hexString

// Array
extension Array {
    subscript(safe idx: Int) -> Element? {
        return (startIndex..<endIndex).contains(idx) ? self[idx] : nil
    }
}

// Test
let testArray = [1, 2, 3]
testArray[safe: 1]
testArray[safe: 3]
testArray[safe: -1]

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

    var hasElements: Bool {
        return !isEmpty
    }
}

// Test
[1, 2, 3, 4].hasElements

