//
//  ViewController.swift
//  KebukeApp
//
//  Created by Sara Yang on 2022/7/5.
//

import UIKit

class ViewController: UIViewController {
    var apiHelper = APIHelper()
    var drinks : [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "PriceVC") as? PriceVC else {
            print("cant find priceVC")
            return
        }
        self.getList(){ (success, drinks) in
            if success {
                self.drinks = drinks
                VC.drinks = drinks
                print("aaa" , drinks.count)
                DispatchQueue.main.async() { [weak self] in
                    self?.navigationController?.pushViewController(VC, animated: false)
                }
            }
        }
        
    }
    
    func getList(completionHandler : @escaping (Bool , [Record])->Void ) {
        if let url = URL(string: "https://api.airtable.com/v0/appt9HcmcTR9r6DZQ/kebuke") {
            apiHelper.getList(url, ["Authorization": "Bearer keyy6p9d8CHUwIM9j"]) { (success, content) in
                if success {
                    let data = Data((content ?? "").utf8)
                    var drinks : [Record] = []
                    
                    do {
                        let response = try JSONDecoder().decode(MyData.self, from: data)
                        for record in response.records {
                            drinks.append(record)
//                            print("xxxx drink name ", record.fields.name)
                        }
                        
                        completionHandler(true, drinks)
                        
                       } catch {
                           print(error)
                           completionHandler(false, [])
                       }
                    
                } else {
                    completionHandler(false, [])
                    print("xxxx fail", content ?? "nil")
                }
            }
        } else {
            completionHandler(false, [])
        }
        
    }
}


struct MyData: Codable {
    let records: [Record]
    
    init(records: [Record]) {
        self.records = records
     }
}

// MARK: - Record
struct Record: Codable {
    let id: String
    let fields: Fields
    
    init(id: String , fields: Fields) {
        self.id = id
        self.fields = fields
     }
}


// MARK: - Fields
struct Fields: Codable {
    let name: String?
    let image: [Image]?
    let mediumPrice : Int?
    let largePrice: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case image = "image"
        case mediumPrice = "price_m"
        case largePrice = "price_l"
    }
    
    init(name: String , image: [Image], mediumPrice: Int, largePrice: Int) {
        self.name = name
        self.image = image
        self.mediumPrice = mediumPrice
        self.largePrice = largePrice
     }
}

// MARK: - Image
struct Image: Codable {
    let url: URL
    
    init(url : URL) {
        self.url = url
    }
}
