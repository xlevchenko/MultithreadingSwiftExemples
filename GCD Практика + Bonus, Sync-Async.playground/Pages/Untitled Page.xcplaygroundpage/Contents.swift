import UIKit
import PlaygroundSupport


class MyViewController: UIViewController {
    
    var bottom = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View Conroller 1"
        view.backgroundColor = .white
        
        bottom.addTarget(self, action: #selector(press), for: .touchUpInside)
    }
    
    @objc func press() {
        let vc = MyViewController2()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        initButtom()
    }
    
    func initButtom() {
        bottom.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        bottom.layer.cornerRadius = 16
        bottom.center = view.center
        bottom.setTitle("Press", for: .normal)
        bottom.backgroundColor = .systemYellow
        bottom.setTitleColor(.black, for: .normal)
        view.addSubview(bottom)
    }
}


class MyViewController2: UIViewController {
    
    let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "View Conroller 2"
        loadImage()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configureImage()
    }
    
    
    func configureImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        view.addSubview(image)
    }
    
    
    func loadImage() {
        let imageURL: URL = URL(string: "https://www.planetware.com/wpimages/2022/03/california-southern-california-top-things-to-do-santa-monica-santa-monica-pier3.jpg")!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                
                //UI всегда возвращаем в main потоке асинхроно
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
}


let vc = MyViewController()
let navBar = UINavigationController(rootViewController: vc)
navBar.view.frame = CGRect(x: 0, y: 0, width: 320, height: 550)

PlaygroundPage.current.liveView = navBar
PlaygroundPage.current.needsIndefiniteExecution = true
