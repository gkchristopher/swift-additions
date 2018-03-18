import Foundation
import PlaygroundSupport

/// Adds weak capture when setting a closure so
/// delegating class does not creat retain cycle
/// by forgetting to use weak capture.
struct DelegatedCall<Input> {

    private(set) var callback: ((Input) -> Void)?

    mutating func delegate<Object: AnyObject>(to object: Object, with callback: @escaping (Object, Input) -> Void) {
        self.callback = { [weak object] input in
            guard let object = object else {
                return
            }
            callback(object, input)
        }
    }
}

// Test
class MyApi {
    var delegateCallback = DelegatedCall<String>()

    func performTask() {
        let newString = ["This", "is", "a", "string."].joined(separator: " ")
        self.delegateCallback.callback?(newString)
    }
}

class User {
    let api = MyApi()
    var aString: String?

    init() {
        api.delegateCallback.delegate(to: self) { (self, someString) in
            self.aString = someString
            print(someString)
        }
    }

    func getString() {
        api.performTask()
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
let user = User()
user.getString()

// Generic Counted Set
struct CustomCountedSet<T: Any> {
    private let internalSet = NSCountedSet()

    mutating func add(_ obj: T) {
        internalSet.add(obj)
    }

    mutating func remove(_ obj: T) {
        internalSet.remove(obj)
    }

    func count(for obj: T) -> Int {
        return internalSet.count(for: obj)
    }
}

// Tests
var countedSet = CustomCountedSet<String>()
countedSet.add("Hello")
countedSet.add("World")
countedSet.add("Hello")
countedSet.count(for: "Hello")

// Generic Deque
struct Deque<T> {
    private var internalArray = [T]()

    mutating func pushBack(_ obj: T) {
        internalArray.append(obj)
    }

    mutating func pushFront(_ obj: T) {
        internalArray.insert(obj, at: 0)
    }

    mutating func popBack() -> T? {
        return internalArray.popLast()
    }

    mutating func popFront() -> T? {
        if internalArray.isEmpty {
            return nil
        } else {
            return internalArray.removeFirst()
        }
    }
}

// Tests
var testDeque = Deque<Int>()
testDeque.pushBack(3)
testDeque.pushFront(2)
testDeque.pushBack(7)

dump(testDeque)

testDeque.popFront()
testDeque.popBack()
testDeque.popFront()
testDeque.popFront()

PlaygroundPage.current.finishExecution()
