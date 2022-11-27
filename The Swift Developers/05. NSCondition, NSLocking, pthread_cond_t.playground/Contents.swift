import UIKit

var str = "NSCondition()"

// MARK: - Pthread Condition
var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()

final class ConditionMutexPrinter: Thread {
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod() {
        pthread_mutex_lock(&mutex)
        
        print("Printer enter")
        
        while !available {
            pthread_cond_wait(&condition, &mutex)
        }
        
        available = false
        
        do {
            pthread_mutex_unlock(&mutex)
        }
        
        print("Printer exit")
    }
}

final class ConditionMutexWriter: Thread {
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writerMethod()
    }
    
    private func writerMethod() {
        pthread_mutex_lock(&mutex)
        print("Writer enter")
        available = true
        pthread_cond_signal(&condition)
        do {
            pthread_mutex_unlock(&mutex)
        }
        print("Writer exit")
    }
}

let conditionMutexWriter = ConditionMutexWriter()
let conditionMutexPrinter = ConditionMutexPrinter()
//conditionMutexWriter.start()
//conditionMutexPrinter.start()


// MARK: - NSCondition
let cond = NSCondition()
var availables = false

class WriterThread: Thread {
    override func main() {
        cond.lock()
        print("WriterThread enter")
        availables = true
        cond.signal()
        cond.unlock()
        print("WriterThread exit")
    }
}

class PrinterThread: Thread {
    override func main() {
        cond.lock()
        print("PrinterThread enter")

        
        while !availables {
            cond.wait()
        }
        
        availables = false
        
        cond.unlock()
        print("PrinterThread exit")
    }
}


let writer = WriterThread()
let printer = PrinterThread()
printer.start()
writer.start()
