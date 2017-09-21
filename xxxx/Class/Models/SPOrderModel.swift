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
     dynamic var idAddress:Int = 0
     dynamic var idProduct:Int = 0
     dynamic var numberOfSale:Int = 0
     dynamic var des:String = ""
     dynamic var paid:Bool = false
     dynamic var categoryId:Int = -1
     dynamic var categoryName:String = ""
     dynamic var totalProduct:Int = 0
     dynamic var minTimeShip:Date = Date()
     dynamic var maxTimeShip:Date = Date()
    
}
