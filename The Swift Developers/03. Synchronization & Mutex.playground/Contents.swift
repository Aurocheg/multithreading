import UIKit

var lesson3 = "Synchronization & Mutex"

/// Mutex - защита объекта от потока

// MARK: - Блок кода на С
/*
class SaveThread {
    private var mutex = pthread_mutex_t()
    
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    func someMethod(completion: () -> ()) {
        pthread_mutex_lock(&mutex)
        /// Все, что будет внутри mutex будет защищено от других потоков.
        // ...
        completion()
        /// В случае, если приложение упадет, чтобы освободить потоки.
        do {
            pthread_mutex_unlock(&mutex)
        }
    }
}
*/

// MARK: - Блок кода на Objective C
class SaveThread {
    private let lockMutex = NSLock()
    
    func someMethod(completion: () -> ()) {
        lockMutex.lock()
        completion()
        do {
            lockMutex.unlock()
        }
    }
}

var array = [String]()
let saveThread = SaveThread()

saveThread.someMethod {
    print("test")
    array.append("1 thread")
}

array.append("2 thread")
