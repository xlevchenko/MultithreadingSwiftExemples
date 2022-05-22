import UIKit
import Darwin
//C
class SaveThread {
    private var mutex = pthread_mutex_t()
        
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    func someMethod(complition: () -> Void) {
        pthread_mutex_lock(&mutex)
        complition()
        defer {
            pthread_mutex_unlock(&mutex)
        }
    }
}

var array = [String]()
let saveThread = SaveThread()

saveThread.someMethod {
    array.append("1 thread")
}

array.append("2 thread")


//Swift
class SaveNsThread {
    private var lockMutex = NSLock()
    
    func someMethod(complition: () -> Void) {
        lockMutex.lock()
        complition()
        defer {
            lockMutex.unlock()
        }
    }
}

var array2 = [String]()
let saveNsThread = SaveNsThread()
saveNsThread.someMethod {
    array.append("NSThread1")
}
array.append("NSThread2")
