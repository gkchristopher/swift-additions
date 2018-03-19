import Foundation


protocol Identifiable {
    associatedtype ID
    static var idKey: WritableKeyPath<Self, ID> { get }
}

struct Person: Identifiable {
    static let idKey = \Person.socialSecurityNumber
    var socialSecurityNumber: String
    var name: String
}

func printID<T: Identifiable>(thing: T) {
    return print(thing[keyPath: T.idKey])
}

let person = Person(socialSecurityNumber: "123-45-6789", name: "Taylor Swift")
printID(thing: person)
person[keyPath: Person.idKey]
