import UIKit
import Darwin
import Foundation

//NSCondition


//C
var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()

// первый поток
class ConditionMutexPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printer()
    }
    
    private func printer() {
        pthread_mutex_lock(&mutex)
        print("Printer Enter")
        while (!available) {
            pthread_cond_wait(&condition, &mutex)
        }
        available = false
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Printer Exit")
    }
}


//второй поток
class ConditionMutexWriter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writer()
    }
    
    private func writer() {
        pthread_mutex_lock(&mutex)
        print("Writer Enter")
        available = true
        pthread_cond_signal(&condition)
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("Writer Exit")
    }
}

let conditionMutexWriter = ConditionMutexWriter()

let conditionMutexPrinter = ConditionMutexPrinter()


conditionMutexPrinter.start()
conditionMutexWriter.start()


//Swift
//NSCondition

var nsCondition = NSCondition()
var avalibles = false

class NSWriter: Thread {
    
    override func main() {
        nsCondition.lock()
        print("NSWriter Enter")
        avalibles = true
        nsCondition.signal()
        
        defer {
            nsCondition.unlock()
        }
        print("NSWriter Exit")
    }
}


class NSPrinter: Thread {
    
    override func main() {
        nsCondition.lock()
        print("NSPrinter Enter")
        while (!avalibles) {
            nsCondition.wait()
        }
        avalibles = false
        
        defer {
            nsCondition.unlock()
        }
        print("NSPrinter Exit")
    }
}

let writet = NSWriter()
let printer = NSPrinter()
printer.start()
writet.start()

