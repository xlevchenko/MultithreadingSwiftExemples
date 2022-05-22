import UIKit
import PlaygroundSupport

print(Thread.current)

//
//let operation1 = {
//    print("Start")
//    print(Thread.current)
//    print("Finish")
//}
//
//
//let queue = OperationQueue()

//queue.addOperation(operation1)

//
//var result: String?
//
//let concantOperation = BlockOperation {
//    result = "The Swift" + " " + "Developer"
//    print(Thread.current)
//}
//
////concantOperation.start()
//
//
//let queue = OperationQueue()
//queue.addOperation(concantOperation)

//print(result!)


//let queue = OperationQueue()
//queue.addOperation {
//    print("Write some")
//    print(Thread.current)
//}


//class MyThread: Thread {
//    override func main() {
//        print("Test main thread")
//    }
//}
//
//let myThread = MyThread()
//myThread.start()


class OperationA: Operation {
    override func main() {
        print("Test2")
        print(Thread.current)
    }
}

let operationA = OperationA()
//operationA.start()

let queue1 = OperationQueue()
queue1.addOperation(operationA)
