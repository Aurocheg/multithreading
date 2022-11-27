import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "GCD Semaphores"

// 1)
let queue = DispatchQueue(label: "The Swift Developer", attributes: .concurrent)

let semaphore = DispatchSemaphore(value: 1)

queue.async {
    semaphore.wait() // -1
    sleep(3)
    print("method 1")
    semaphore.signal() // +1
}

queue.async {
    semaphore.wait() // -1
    sleep(3)
    print("method 2")
    semaphore.signal() // +1
}

queue.async {
    semaphore.wait() // -1
    sleep(3)
    print("method 3")
    semaphore.signal() // +1
}

// 2)
let sem = DispatchSemaphore(value: 2)

DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
    sem.wait(timeout: DispatchTime.distantFuture)
    sleep(1)
    print("Block", String(id))
    sem.signal()
}

class SemaphoreTest {
    private let semaphore = DispatchSemaphore(value: 2)
    private var array = [Int]()
    
    private func methodWork(_ id: Int) {
        self.semaphore.wait() // -1
        array.append(id)
        print("test array", array.count)
        
        Thread.sleep(forTimeInterval: 2)
        semaphore.signal() // +1
    }
    
    public func startAllThreads() {
        DispatchQueue.global().async {
            self.methodWork(111)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(1231)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(13211)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(132341)
            print(Thread.current)
        }
    }
}

let semaphoreTest = SemaphoreTest()
semaphoreTest.startAllThreads()
