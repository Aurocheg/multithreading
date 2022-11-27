import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Operation and Operation Queue"

/*
print(Thread.current)

// closure
let operation1 = {
    print("Started")
    print(Thread.current)
    print("Finished")
}

// сразу переводит в асинхронный формат
let queue = OperationQueue()
queue.addOperation(operation1)
*/


/*
print(Thread.current)

var result: String?
let concatOperation = BlockOperation {
    result = "The Swift Developers"
    print(Thread.current)
}

//concatOperation.start()
//print(result!)

let queue = OperationQueue()
queue.addOperation(concatOperation)
*/

/*
 print(Thread.current)
 let queue1 = OperationQueue()
 queue1.addOperation {
 print("test")
 print(Thread.current)
 print("finish")
 }
 */


print(Thread.current)

class MyThread: Thread {
    override func main() {
        print("Test main thread")
    }
}

let myThread = MyThread()
myThread.start()

class OperationA: Operation {
    override func main() {
        print("Test Operation A")
        print(Thread.current)
    }
}

let operationA = OperationA()
//operationA.start()

let queue1 = OperationQueue()
queue1.addOperation(operationA)
