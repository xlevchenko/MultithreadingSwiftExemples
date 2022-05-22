import UIKit
import Darwin


class QueueTest1 {
    private let serialQueue = DispatchQueue(label: "serialTest")
    private let concurrentQueue = DispatchQueue(label: "concurrentTest", attributes: .concurrent)
}


class QueueTest2 {
    private let globalQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
}


//DeadLock
//Cамый примитивный кейс бесконечной блокировки ресурса:
class DeadLock {
    let lock = NSLock()
    
    var boolPredicate = true
    var counter = 0
    
    func test() {
        lock.lock()
        
        counter += 1
        print("\(counter)")
        boolPredicate = counter < 10
        
        if boolPredicate == true {
            test()
        }
    
        lock.unlock()
    }
}

var deadlock = DeadLock()
deadlock.test()



//Воспроизведем deadlock с использованием вложенных блокировок ресурсов:
class DeadLock1 {
    
    let lock1 = NSLock()
    let lock2 = NSLock()
    
    var resource1 = 0
    var resource2 = 0
    
    func someTest() {
        let thread1 = Thread {
            self.lock1.lock()
            self.resource1 = 1
            
            self.lock2.lock()
            self.resource2 = 1
            
            self.lock1.unlock()
            self.lock2.unlock()
        }
        
        let thread2 = Thread {
            self.lock2.lock()
            self.resource2 = 1
            
            self.lock1.lock()
            self.resource1 = 1
            
            self.lock1.unlock()
            self.lock2.unlock()
        }
        thread1.start()
        thread2.start()
    }
}

let deadLock1 = DeadLock1()
deadLock1.someTest()
