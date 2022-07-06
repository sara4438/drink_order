//
//  PriceVC.swift
//  KebukeApp
//
//  Created by Sara Yang on 2022/7/5.
//

import UIKit

class PriceVC: UIViewController{

    @IBOutlet weak var priceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.priceTableView.delegate = self
        self.priceTableView.dataSource = self
        self.priceTableView.rowHeight = 100
    }
    
    

}

extension PriceVC: UITableViewDelegate  ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PriceCell else {
            print("!!!!")
            return PriceCell()
        }
        cell.imgDrink.image = UIImage(named: "1")
        cell.lbMPrice.text = "35"
        cell.lbName.text = "春芽冷露"
        cell.lbLPrice.text = "45"
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
