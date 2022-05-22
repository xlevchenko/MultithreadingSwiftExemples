import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true



//class DispatchWorkItem1 {
//    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
//
//    func create() {
//        let workItem = DispatchWorkItem {
//            print(Thread.current)
//            print("Start task")
//        }
//        workItem.notify(queue: .main) {
//            print(Thread.current)
//            print("Task finish")
//        }
//        queue.async(execute: workItem)
//    }
//}

//let dispatchWorkItem1 = DispatchWorkItem1()
//dispatchWorkItem1.create()


//class DispatchWorkItem2 {
//    private let queue = DispatchQueue(label: "DispatchWorkItem1")
//    
//    func create() {
//        queue.async {
//            sleep(1)
//            print(Thread.current)
//            print("Task1")
//        }
//        
//        queue.async {
//            sleep(1)
//            print(Thread.current)
//            print("Task 2")
//        }
//        
//        let workItem = DispatchWorkItem {
//            print(Thread.current)
//            print("Start work item task")
//        }
//        
//        queue.async(execute: workItem)
//    }
//}
//
//let dispatchWorkItem2 = DispatchWorkItem2()
//
//dispatchWorkItem2.create()


var view = UIView(frame: .init(x: 0, y: 0, width: 800, height: 800))
var images = UIImageView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))

images.backgroundColor = .systemYellow
images.contentMode = .scaleAspectFit
view.addSubview(images)

PlaygroundPage.current.liveView = images


let imageURL = URL(string: "https://www.pixsy.com/wp-content/uploads/2021/04/ben-sweet-2LowviVHZ-E-unsplash-1.jpeg")

//1. #Classic
func featchImage() {
    let queue = DispatchQueue.global(qos: .utility)
    queue.async {
        if let data = try? Data(contentsOf: imageURL!) {
            DispatchQueue.main.async {
                images.image = UIImage(data: data)
            }
        }
    }
}

//featchImage()


//2. #DispftchWorkItem

func featchImage2() {
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        data = try? Data(contentsOf: imageURL!)
        print(Thread.current)
    }
    queue.async(execute: workItem)
    workItem.notify(queue: DispatchQueue.main) {
        if let data = data {
            images.image = UIImage(data: data)
        }
    }
}

//featchImage2()


//3. #URLSession


func featchImage3() {
    let task = URLSession.shared.dataTask(with: imageURL!) { data, ressponse, error in
        print(Thread.current)
        
        if let data = data {
            DispatchQueue.main.async {
                print(Thread.current)
                images.image = UIImage(data: data)
            }
        }
    }
    task.resume()
}

featchImage3()
