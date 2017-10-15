//
//  SPOrderModel.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import RealmSwift
import Realm


class SPOrderModel: SPBaseModelRealm {
     dynamic var nameGuest:String = ""
     dynamic var phoneNumber:String = ""
     dynamic var nameProduct:String = ""
     dynamic var soldProduct:Int = 0
     dynamic var priceShip:Int = 0
     dynamic var des:String = ""
     dynamic var paid:Bool = false
     dynamic var categoryId:Int = -1
     dynamic var categoryName:String = ""
     dynamic var totalProduct:Int = 0
     dynamic var minTimeShip:Date = Date()
     dynamic var maxTimeShip:Date = Date()
     dynamic var nameAddress:String = ""
     dynamic var latitude:Double = 0.0
     dynamic var longitude:Double = 0.0
     dynamic var distance:String = "0"
     dynamic var time:String = "0"
}
