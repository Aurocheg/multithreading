import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg", "http://bestkora.com/IosDeveloper/w-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.jpg", "http://www.picture-newsletter.com/arctic/arctic-12.jpg" ]

var str = "Dispatch Group"


final class DispatchGroupTest1 {
    private let queueSerial = DispatchQueue(label: "The Swift Developers")
    
    private let groupRed = DispatchGroup()
    
    public func loadInfo() {
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("1")
        }
        
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("2")
        }
        
        groupRed.notify(queue: .main) {
            print("Group Red had finished all work")
        }
    }
}

let dispatchGroupTest1 = DispatchGroupTest1()
//dispatchGroupTest1.loadInfo()


final class DispatchGroupTest2 {
    private let queueConcurrent = DispatchQueue(label: "The Swift Developers", attributes: .concurrent)
    
    private let groupBlack = DispatchGroup()
    
    public func loadInfo() {
        groupBlack.enter()
        queueConcurrent.async {
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
        
        groupBlack.enter()
        queueConcurrent.async {
            sleep(2)
            print("2")
            self.groupBlack.leave()
        }
        
        // блок ниже выполняться не будет, пока не выполнится асинхронный код выше
        groupBlack.wait()
        print("finish all")
        
        groupBlack.notify(queue: .main) {
            print("Group Black was finished all work")
        }
    }
}

let dispatchGroupTest2 = DispatchGroupTest2()
dispatchGroupTest1.loadInfo()


final class EightImage: UIView {
    public var imagesArray = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        [
            UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)),
        ].forEach {imageView in
            imagesArray.append(imageView)
        }
        
        [
            UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)),
        ].forEach {imageView in
            imagesArray.append(imageView)
        }
        
        for imageView in imagesArray {
            imageView.contentMode = .scaleToFill
            self.addSubview(imageView)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var view = EightImage(frame: CGRect(x: 0, y: 0, width: 700, height: 900))
view.backgroundColor = .systemOrange

var images = [UIImage]()

PlaygroundPage.current.liveView = view

func asyncLoadImage(imageURL: URL,
                    runQueue: DispatchQueue,
                    completionQueue: DispatchQueue,
                    completion: @escaping (UIImage?, Error?) -> ()) {
    runQueue.async {
        do {
            let data = try Data(contentsOf: imageURL)
            completionQueue.async {
                completion(UIImage(data: data), nil)
            }
        } catch let error {
            completionQueue.async {
                completion(nil, error)
            }
        }
    }
}

func asyncGroup() {
    let group = DispatchGroup()
    
    for i in 0...3 {
        group.enter()
        asyncLoadImage(imageURL: URL(string: imageURLs[i])!,
                       runQueue: .global(),
                       completionQueue: .main) { (image, error) in
            guard let image1 = image else { return }
            images.append(image1)
            group.leave()
        }
    }
    
    group.notify(queue: .main) {
        for i in 0...3 {
            view.imagesArray[i].image = images[i]
        }
    }
}

func asyncURLSession() {
    for i in 4...7 {
        let url = URL(string: imageURLs[i - 4])
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                view.imagesArray[i].image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

//asyncGroup()
asyncURLSession()
