//
//  ViewController.swift
//  KebukeApp
//
//  Created by Sara Yang on 2022/7/5.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "PriceVC") as? PriceVC else {
            print("cant find priceVC")
            return
        }
        self.present(VC, animated: false)
    }

}

