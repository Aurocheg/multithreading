import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Barrier"

/*
var array = [Int]()

for i in 0...9 {
    array.append(i)
}

print(array)
print(array.count)
*/

/*
var array = [Int]()

// параллельно, race condition
DispatchQueue.concurrentPerform(iterations: 10) {index in
    array.append(index)
}

print(array)
print(array.count)
*/

final class SafeArray<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "The Swift Developers", attributes: .concurrent)
    
    public var valueArray: [T] {
        var result = [T]()
        queue.sync {
            result = self.array
        }
        return result
    }
    
    public func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
}

var safeArray = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { index in
    safeArray.append(index)
}

print("safeArray", safeArray.valueArray)
print("safeArray count", safeArray.valueArray.count)
