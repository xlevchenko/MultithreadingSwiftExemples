import UIKit
import PlaygroundSupport
import Darwin

class DispatchGroupTest1 {
    private let queueSerial = DispatchQueue(label: "QueueSerial")
    
    private let groupRed = DispatchGroup()
    
    func loadInfo() {
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("1")
        }
        
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("2")
        }
        
        groupRed.notify(queue: .main) {
            print("Group red finish all")
        }
    }
}

let dispatchGroupTest1 = DispatchGroupTest1()
//dispatchGroupTest1.loadInfo()


class DispatchGroupTest2 {
    private let queueConcurrent = DispatchQueue(label: "QueueSerial", attributes: .concurrent)
    
    private let groupBlack = DispatchGroup()
    
    func loadInfo() {
        groupBlack.enter()
        
        queueConcurrent.async {
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
       
        groupBlack.enter()
        queueConcurrent.async {
            sleep(1)
            print("2")
            self.groupBlack.leave()
        }
        
        groupBlack.wait()
        print("Finish All")
        
        groupBlack.notify(queue: .main) {
            print("Finish all in main ")
        }
    }
    
}

let dispatchGroupTest2 = DispatchGroupTest2()
//dispatchGroupTest2.loadInfo()


class EightImage: UIView {
    public var ivs = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0...7 {
            ivs[i].contentMode = .scaleAspectFit
            self.addSubview(ivs[i])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var view = EightImage(frame: CGRect(x: 0, y: 0, width: 700, height: 900))
view.backgroundColor = .systemYellow

let imageURLs = ["https://d1don5jg7yw08.cloudfront.net/800x800/nft-images/20210727/Black_NinJaw_Pxl_1627404103610.png",
                 "https://res.cloudinary.com/upwork-cloud/video/upload/c_scale,w_1000/v1631216358/catalog/1436048135547224064/mfzeklpaznms58dwecbk.JPEG",
                 "https://www.arweave.net/6RxsiW0Tv4NjqZW1ogIPGqDQQotyXjZtgzY3_GZtGfg?ext=PNG",
                 "https://airnfts.s3.amazonaws.com/nft-images/20210619/NEKOPOPS_22_1624126550941.png",
]


var image = [UIImage]()

PlaygroundPage.current.liveView = view

func asyncLoadImage(imageURL: URL, runQueue: DispatchQueue, completionQueue: DispatchQueue, complition: @escaping (UIImage?, Error?) -> Void) {
    
    runQueue.async {
        do {
         let data = try Data(contentsOf: imageURL)
            completionQueue.async {
                complition(UIImage(data: data)!, nil)
            }
        } catch let error {
            complition(nil, error)
        }
    }
}

func asyncGroup() {
    let aGroup = DispatchGroup()
    
    for i in 0...3 {
        aGroup.enter()
        asyncLoadImage(imageURL: URL(string: imageURLs[i])!,
                       runQueue: .global(),
                       completionQueue: .main) { result, error in
            guard let image1 = result else { return }
            image.append(image1)
            aGroup.leave()
        }
    }
    aGroup.notify(queue: .main) {
        for i in 0...3 {
            view.ivs[i].image = image[i]
        }
    }
}



//other
func asyncURLSession() {
    for i in 4...7 {
        let url = URL(string: imageURLs[i - 4])
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, respons, error in
            DispatchQueue.main.async {
                view.ivs[i].image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

asyncGroup()
asyncURLSession()
