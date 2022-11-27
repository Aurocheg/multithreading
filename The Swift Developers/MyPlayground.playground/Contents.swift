import UIKit

/*
 func test(completion: () -> ()) {
 print("Task 1")
 
 completion()
 
 print("Task 3")
 }
 
 test {
 print("Task 2")
 }
 */

enum ButtonColor: Int {
    case black = 0
    case white = 1
}

func test(buttonColor: ButtonColor) {
    switch buttonColor {
    case .black:
        print("black")
        buttonColor.rawValue
    case .white:
        print("white")
    }
}

test(buttonColor: .black)
