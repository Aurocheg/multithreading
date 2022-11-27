import UIKit
import PlaygroundSupport

/*
let queue = DispatchQueue (label: "The Swift Dev")
queue.async {
    queue.sync {
        // deadlock
    }
}

let queue = DispatchQueue(label: "The Swift Dev")
queue.sync {
    print(Thread.isMainThread) // true
    DispatchQueue.main.sync {
        // deadlock
    }
}
*/

class MyViewController: UIViewController {
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "VC 1"
        
        view.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initButton()
    }
    
    private func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("Press", for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
    }
    
    @objc func buttonTapped() {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

class SecondViewController: UIViewController {
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "VC 2"
        
        view.backgroundColor = UIColor.white
        
        loadPhoto()
        
//        let imageURL: URL = URL(string: "https://www.visittheusa.com/sites/default/files/styles/hero_l/public/images/hero_media_image/2016-10/HERO1_stock-photo-landscape-of-the-ventura-pier-and-the-c-street-surf-break-.jpg?itok=mesChj9f")!
//
//        if let data = try? Data(contentsOf: imageURL) {
//            self.imageView.image = UIImage(data: data)
//        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initImage()
    }
    
    func initImage() {
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        view.addSubview(imageView)
    }
    
    func loadPhoto() {
        let imageURL: URL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}

let vc = MyViewController()
let navbar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navbar
