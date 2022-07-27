//
//  PriceVC.swift
//  KebukeApp
//
//  Created by Sara Yang on 2022/7/5.
//

import UIKit


class PriceVC: UIViewController, ShowDelegate  {
    

    @IBOutlet weak var priceTableView: UITableView!
    @IBOutlet weak var viewCart: UIView!
    var myCart : ShoppingCart?
    
    var drinks: [Record] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.priceTableView.delegate = self
        self.priceTableView.dataSource = self
        self.priceTableView.rowHeight = 100
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        print(" myCart?.drinkOrders.isEmpty",  myCart?.drinkOrders.isEmpty)
        self.viewCart.isHidden = myCart?.drinkOrders.isEmpty ?? true
                
    }
    
    
    @IBAction func goToDetail(_ sender: Any) {
//        guard let VC = storyboard?.instantiateViewController(withIdentifier: "DrinkDetailVC") as? DrinkDetailVC else {
//            print("cant find DrinkDetailVC")
//            return
//        }
//        self.navigationController?.pushViewController(VC, animated: false)
//
        
    }
    func show(_ drink : DrinkOrder) {
        print("show")
        if let cart = myCart {
            cart.drinkOrders.append(drink)
            cart.totalAmount += drink.price
        } else {
            self.myCart = ShoppingCart()
            self.myCart?.drinkOrders.append(drink)
        }
        

        
    }
    

}

extension PriceVC: UITableViewDelegate  ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PriceCell else {
            return PriceCell()
        }
        let theDrink = self.drinks[indexPath.row]
        let url : URL = theDrink.fields.image?.first?.url ?? URL(string: "www.google.com")!
        cell.imgDrink.downloaded(from: url)
        cell.lbMPrice.text = theDrink.fields.mediumPrice != nil ? String(theDrink.fields.mediumPrice!) : ""
        cell.lbName.text = theDrink.fields.name
        cell.lbLPrice.text = theDrink.fields.largePrice != nil ? String(theDrink.fields.largePrice!) : ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var record = drinks[indexPath.row]
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "DrinkDetailVC") as? DrinkDetailVC else {
                   print("cant find DrinkDetailVC")
                   return
               }
        
        VC.record = record
        VC.delegate? = self
        self.navigationController?.pushViewController(VC, animated: false)
        
    }
    
    
}

class PriceCell: UITableViewCell {
    
    @IBOutlet weak var imgDrink: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbMPrice: UILabel!
    @IBOutlet weak var lbLPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}

protocol ShowDelegate: AnyObject {
    func show(_ drink: DrinkOrder)
}


