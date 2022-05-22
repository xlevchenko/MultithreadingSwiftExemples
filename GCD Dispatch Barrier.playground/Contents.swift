import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true




//for i in 0...9 {
//    array.append(i)
//}
//
//print(array)
//print(array.count)



//var array = [Int]()
//
//DispatchQueue.concurrentPerform(iterations: 10) { index in
//    array.append(index)
//}
//print(array)
//print(array.count)


class SaveArray<T> {
    private var array = [T]()
    
    private let queue = DispatchQueue(label: "SaveArray", attributes: .concurrent)
    
    public func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public var valueArray: [T] {
        var result = [T]()
        queue.async {
            result = self.array
        }
        return result
    }
}

let arraySave = SaveArray<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { index in
    arraySave.append(index)
}

print("arraySave:", arraySave.valueArray)
print("arraySaveCount:", arraySave.valueArray.count)
