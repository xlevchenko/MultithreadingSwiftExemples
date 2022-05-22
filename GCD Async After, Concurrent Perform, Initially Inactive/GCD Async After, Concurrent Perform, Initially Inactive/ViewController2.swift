//
//  ViewController2.swift
//  GCD Async After, Concurrent Perform, Initially Inactive
//
//  Created by Olexsii Levchenko on 5/5/22.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        for i in 0...2000000 {
//            print(i)
//        }
        
        
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 2000) {
//                print("\($0) times")
//                print(Thread.current)
//            }
//        }
        myInactiveQueue()
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "Levchenko", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("Done!")
        }
        print("Not yet startet...")
        inactiveQueue.activate()
        print("Activate!")
        inactiveQueue.suspend()
        print("Pause!")
        inactiveQueue.resume()
    }
}
