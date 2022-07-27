//
//  DrinkDetailVC.swift
//  KebukeApp
//
//  Created by Sara Yang on 2022/7/8.
//

import UIKit

class DrinkDetailVC: UIViewController{
    @IBOutlet weak var sizeSeg: UISegmentedControl!
    @IBOutlet weak var tempSeg: UISegmentedControl!
    @IBOutlet weak var sugarSeg: UISegmentedControl!
    @IBOutlet weak var bubbleSeg: UISegmentedControl!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var personNameTF: UITextField!
    @IBOutlet weak var drinkNameLb: UILabel!
    @IBOutlet weak var drinkImgView: UIImageView!
    
    var total : Int = 0 {
        didSet {
            self.totalLabel.text = "價格 \(total) NTD"
        }
    }
    var drinkOrder : DrinkOrder = DrinkOrder("測試紅茶" ,"華華" )
    var record : Record?
    weak var delegate : ShowDelegate?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.drinkNameLb.text = record?.fields.name ?? ""
        let url : URL = self.record?.fields.image?.first?.url ?? URL(string: "www.google.com")!
        self.drinkImgView.downloaded(from: url)
        
        self.totalLabel.text = "價格 \(self.record?.fields.mediumPrice ?? 0) NTD"
        print("viewDidLoad", record?.fields.name)
    }
    
    @IBAction func changeSize(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.total = self.record?.fields.mediumPrice ?? 0
            
        } else {
            self.total = self.record?.fields.largePrice ?? 0
        }
    }
    @IBAction func changeBubble(_ sender: UISegmentedControl) {
        var tempPrice =  self.sizeSeg.selectedSegmentIndex == 0 ? self.record?.fields.mediumPrice ?? 0 : self.record?.fields.largePrice ?? 0
        switch sender.selectedSegmentIndex {
        case 0:
           break
        case 1:
            tempPrice += 10
        case 2:
            tempPrice += 10
        default:
            break
        }
        self.total = tempPrice
    }
    @IBAction func addToCart(_ sender: Any) {
        self.showAlert()
       
    }
    
    func summarizeOrder() {
        self.drinkOrder.drinkName = self.record?.fields.name ?? "找不到茶"
        self.drinkOrder.size = self.sizeSeg.selectedSegmentIndex == 0 ? .M : .L
        self.drinkOrder.personName = self.personNameTF.text ?? "不寫名字的臭小明"
        
        self.setTemp()
        self.setSugar()
        self.setBubble()
    }
    
    func showAlert() {
        self.summarizeOrder()
        let controller = UIAlertController( title: "", message: "\(self.drinkOrder.personName) 確定加入\(self.drinkOrder.drinkName)\(self.drinkOrder.size) 到購物車？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default) { _ in
           print("成功加入購物車")
            guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "PriceVC") as? PriceVC else {
                       print("cant find PriceVC")
                       return
                   }
            
            VC.show(self.drinkOrder)
            self.navigationController?.popViewController(animated: false)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "再想想", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
          
            
        }
    }
        
    func setBubble() {
        switch self.bubbleSeg.selectedSegmentIndex {
            case 0:
                self.drinkOrder.bubble = .None
            case 1:
                self.drinkOrder.bubble = .WhiteBubble
            case 2:
                self.drinkOrder.bubble = .ColdBubble
        default:
            self.drinkOrder.bubble = .None

        }
    }
    
    func setSugar() {
        switch self.sugarSeg.selectedSegmentIndex {
            case 0:
                self.drinkOrder.sugar = .NormalSugar
            case 1:
                self.drinkOrder.sugar = .LessSugar
            case 2:
                self.drinkOrder.sugar = .HalfSugar
            case 3:
                self.drinkOrder.sugar = .FewSugar
            case 4:
                self.drinkOrder.sugar = .SugarFree
        default:
            self.drinkOrder.sugar = .NormalSugar
        }
    }
    
    func setTemp() {
        switch self.tempSeg.selectedSegmentIndex {
            case 0:
                self.drinkOrder.temp = .NormalIce
            case 1:
                self.drinkOrder.temp = .LessIce
            case 2:
                self.drinkOrder.temp = .FewIce
            case 3:
                self.drinkOrder.temp = .NoIce
            case 4:
                self.drinkOrder.temp = .Warm
        default:
            self.drinkOrder.temp = .NormalIce
        }
    }
}
    


