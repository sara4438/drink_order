//
//  PriceVC.swift
//  KebukeApp
//
//  Created by Sara Yang on 2022/7/5.
//

import UIKit


class PriceVC: UIViewController{
    @IBOutlet weak var priceTableView: UITableView!
    var drinks: [Record] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.priceTableView.delegate = self
        self.priceTableView.dataSource = self
        self.priceTableView.rowHeight = 100
        self.navigationItem.setHidesBackButton(true, animated: false)

    }
    
    
    @IBAction func goToDetail(_ sender: Any) {
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "DrinkDetailVC") as? DrinkDetailVC else {
            print("cant find DrinkDetailVC")
            return
        }
        self.navigationController?.pushViewController(VC, animated: false)
     
        
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
