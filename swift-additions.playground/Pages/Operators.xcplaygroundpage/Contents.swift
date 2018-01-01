//: Playground - noun: a place where people can play

import Foundation

// Range operators

precedencegroup RangeFormationPrecedence {
    associativity: left
    higherThan: CastingPrecedence
}

infix operator ... : RangeFormationPrecedence

func ...(lhs: CountableClosedRange<Int>, rhs: Int) -> [Int] {
    let downwards = (rhs..<lhs.upperBound).reversed()
    return Array(lhs) + downwards
}

let range = 1...10...1
print(range)
