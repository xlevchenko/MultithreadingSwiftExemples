//
//  ViewController1.swift
//  GCD Async After, Concurrent Perform, Initially Inactive
//
//  Created by Olexsii Levchenko on 5/5/22.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        afterBlock(seconds: 10, queue: .global()) {
//            print("Hello")
//            print(Thread.current)
//        }
//        afterBlock(seconds: 4) {
//            print("Hello")
//            self.showAlert()
//            print(Thread.current)
//        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), complition: @escaping() -> ()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            complition()
        }
    }
}

