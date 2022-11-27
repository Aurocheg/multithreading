import UIKit
import PlaygroundSupport

class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
    
    func create() {
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start task")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("Task finish")
        }
        
        queue.async(execute: workItem)
    }
}

let dispatchWorkItem1 = DispatchWorkItem1()
//dispatchWorkItem1.create()


class DispatchWorkItem2 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1")
    
    func create() {
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task 1")
        }
        
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task 2")
        }
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start work item task")
        }
        
        queue.async(execute: workItem)
        
        /// чтобы отменить
        workItem.cancel()
    }
}

let dispatchWorkItem2 = DispatchWorkItem2()
//dispatchWorkItem2.create()



var view = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
var eiffelImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
eiffelImage.backgroundColor = .systemYellow
eiffelImage.contentMode = .scaleAspectFit
view.addSubview(eiffelImage)

PlaygroundPage.current.liveView = view

let imageURL = URL(string: "https://www.planetware.com/photos-large/F/france-eiffel-tower-photo-op.jpg")!

// MARK: - 1) cпособ
func fetchImage() {
    let queue = DispatchQueue.global(qos: .utility)
    
    queue.async {
        if let data = try? Data(contentsOf: imageURL) {
            DispatchQueue.main.async {
                eiffelImage.image = UIImage(data: data)
            }
        }
    }
}

//fetchImage()


// MARK: - 2) способ
func fetchImage2() {
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        data = try? Data(contentsOf: imageURL)
        print(Thread.current)
    }
    
    queue.async(execute: workItem)
    
    workItem.notify(queue: .main) {
        if let imageData = data {
            eiffelImage.image = UIImage(data: imageData)
        }
    }
}

//fetchImage2()

// MARK: - 3) способ (URLSession)
func fetchImage3() {
    let task = URLSession.shared.dataTask(with: imageURL) { (data, _, _) in
        print(Thread.current)
        
        if let imageData = data {
            DispatchQueue.main.async {
                print(Thread.current)
                eiffelImage.image = UIImage(data: imageData)
            }
        }
    }
    task.resume()
}

fetchImage3()

