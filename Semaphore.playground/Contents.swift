import UIKit

let semaphore = DispatchSemaphore(value: 1)

DispatchQueue.global().async {
    semaphore.wait() // -1
    sleep(1) // Person 1 playing with Switch
    print("Person 1 - done with Switch")
    semaphore.signal() // +1
}

DispatchQueue.global().async {
    semaphore.wait() // -1
    print("Person 2 - wait finished")
    sleep(1) // Person 2 playing with Switch
    print("Person 2 - done with Switch")
    semaphore.signal() // +1
}
