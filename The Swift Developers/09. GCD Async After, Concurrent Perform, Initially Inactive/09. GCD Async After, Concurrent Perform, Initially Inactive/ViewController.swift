//
//  ViewController.swift
//  09. GCD Async After, Concurrent Perform, Initially Inactive
//
//  Created by Aurocheg on 21.11.22.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        afterBlock(seconds: 4, queue: .global()) {
            print("Hello")
            print(Thread.current)
        */
        
        /*
        afterBlock(seconds: 2, queue: .main) {
            print("Hello")
            self.showAlert()
            print(Thread.current)
        
         */
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }

    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping() -> ()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }
}

