import UIKit
import Darwin


class ReadWriteLook {
    private var look = pthread_rwlock_t()
    private var attribute = pthread_rwlockattr_t()
    
    private var globalProperty: Int = 0
    init() {
        pthread_rwlock_init(&look, &attribute)
    }
    
    public var workProperty: Int {
        get {
            pthread_rwlock_rdlock(&look)
            let temp = globalProperty
            pthread_rwlock_unlock(&look)
            return temp
        }
        set {
            pthread_rwlock_wrlock(&look)
            globalProperty = newValue
            pthread_rwlock_unlock(&look)
        }
    }
}

var read = ReadWriteLook()
read.workProperty = 6


//deprecated in IOS 10.0
class SpinLock {
    private var lock = OS_SPINLOCK_INIT
    
    func some() {
        OSSpinLockLock(&lock)
        //something
        OSSpinLockUnlock(&lock)
    }
}


//пришло вместо SpinLock
class UnfairLock {
    private var lock = os_unfair_lock()
    
    var array = [Int]()
    
    func some() {
        os_unfair_lock_lock(&lock)
        array.append(4)
        os_unfair_lock_unlock(&lock)
    }
}



//Synchronized
class SynchronizedObjc {
   private let lock = NSObject()
    
    var array = [Int]()
    
    func some() {
        objc_sync_enter(lock)
        //something
        array.append(4)
        objc_sync_exit(lock)
    }
}
