import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


//var opertionQueue = OperationQueue()

//class OperationCancelTest: Operation {
//    override func main() {
//        if isCancelled {
//            print(isCancelled)
//            return
//        }
//        print("Test 1")
//        sleep(1)
//
//        if isCancelled {
//            print(isCancelled)
//            return
//        }
//        print("Test 2")
//    }
//}
//
//
//func cancelOperationMethod() {
//    let cancelOperation = OperationCancelTest()
//    opertionQueue.addOperation(cancelOperation)
//    cancelOperation.cancel()
//}
//
//cancelOperationMethod()


class WaitOperationTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        operationQueue.addOperation {
            sleep(1)
            print("Test 1")
        }
        operationQueue.addOperation {
            sleep(2)
            print("Test 2")
        }
        
        operationQueue.waitUntilAllOperationsAreFinished()
        operationQueue.addOperation {
            print("Test 3")
        }
        operationQueue.addOperation {
            print("Test 4")
        }
    }
}


let waitOperationTest = WaitOperationTest()
//waitOperationTest.test()


class WaitOperationTest2 {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            sleep(1)
            print("Test 1")
        }
        let operation2 = BlockOperation {
            sleep(2)
            print("Test 2")
        }
        
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
    }
}

let waitOperationTest2 = WaitOperationTest2()
//waitOperationTest2.test()



class CompletionBlockTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            sleep(3)
            print("Test Comletion Block")
        }
        operation1.completionBlock = {
            print("Finish Completion Block")
        }
        operationQueue.addOperation(operation1)
    }
}


let completionBlock = CompletionBlockTest()
completionBlock.test()
