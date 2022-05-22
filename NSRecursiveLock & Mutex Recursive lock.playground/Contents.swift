import Foundation
import Darwin

//C

//NSRerursiveLock




class RecursiveMutexTest {
    private var mutex = pthread_mutex_t()
    private var atrribute = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&atrribute)
        pthread_mutexattr_settype(&atrribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &atrribute)
    }
    
    func firstTask() {
        pthread_mutex_lock(&mutex)
        secondTask()
        defer {
            pthread_mutex_unlock(&mutex)
        }
    }
    
    private func secondTask() {
        pthread_mutex_lock(&mutex)
        print("Hello World!")
        defer {
            pthread_mutex_unlock(&mutex)
        }
    }
}

let recursiv = RecursiveMutexTest()
recursiv.firstTask()




//Swift
let recursiveLock = NSRecursiveLock()

class RecursiveThread: Thread {
    
    override func main() {
        recursiveLock.lock()
        print("Thread acquired lock")
        task()
        defer {
            recursiveLock.unlock()
        }
        print("Exit main")
    }
    
    
    func task() {
        recursiveLock.lock()
        print("Thread acquired lock")
        print("Task")
        defer {
            recursiveLock.unlock()
        }
        print("Exit task")
    }
}

let thread = RecursiveThread()
thread.start()
