//
//  SecondViewController.swift
//  09. GCD Async After, Concurrent Perform, Initially Inactive
//
//  Created by Aurocheg on 21.11.22.
//

import UIKit

final class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        for i in 0...200000 {
            print(i)
        }
         */
        
        /*
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            /// Параллельные итерации
            DispatchQueue.concurrentPerform(iterations: 200000) {
                print("\($0) times")
                print(Thread.current)
            }
        }
         */
        
        myInactiveQueue()
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "The Swift Developers", attributes: [.concurrent, .initiallyInactive])
        inactiveQueue.async {
            print("Done")
        }
        printContent("Not yet started")
        inactiveQueue.activate()
        print("Activate!")
        inactiveQueue.suspend()
        print("Pause@")
        inactiveQueue.resume()
    }
}
