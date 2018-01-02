import Foundation

extension Array {
    subscript(safe idx: Int) -> Element? {
        return idx < endIndex ? self[idx] : nil
    }
}

let testArray = [1, 2, 3]
testArray[safe: 7]
