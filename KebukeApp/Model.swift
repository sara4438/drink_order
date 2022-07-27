//
//  Model.swift
//  KebukeApp
//
//  Created by Sara Yang on 2022/7/22.
//

import Foundation


class DrinkOrder {
    var personName: String = ""
    var drinkName : String = ""
    var image : URL?
    var size : Size = .M
    var sugar : Sugar = .NormalSugar
    var temp : Temperature = .NormalIce
    var bubble : Chew = .None
    var price : Int = 0
    
    init(_ drinkName:String, _ personName: String) {
        self.drinkName = drinkName
        self.personName = personName
    }
}

class ShoppingCart {
    var drinkOrders : [DrinkOrder] = []
    var totalAmount : Int = 0
    
}

enum Size :String {
    case M
    case L
}

enum Sugar {
    case NormalSugar
    case LessSugar
    case HalfSugar
    case FewSugar
    case SugarFree
}

enum Temperature {
    case NormalIce
    case LessIce
    case FewIce
    case NoIce
    case Warm
}

enum Chew {
    case None
    case WhiteBubble
    case ColdBubble
}
