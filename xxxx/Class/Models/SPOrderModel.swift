//
//  SPOrderModel.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import RealmSwift
import Realm


class Location:NSObject {
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    override init() {
    }
    init(latitude:Double, longitude:Double) {
        
        self.latitude = latitude
        self.longitude = longitude
    }
}

class SPOrderModel: NSObject {
    dynamic var oderId:String = ""
    dynamic var nameGuest:String = ""
    dynamic var phoneNumber:String = ""
    dynamic var address:SPAddress = SPAddress() // tao 1 bang rieng address.vaf 1 bang product 
    dynamic var product:SPProduct = SPProduct()
    dynamic var numberOfSale:Int = 0
    dynamic var des:String = ""
    dynamic var paid:Bool = false
    dynamic var categoryId:Int = -1
    dynamic var categoryName:String = ""
    dynamic var totalProduct:Int = 0
    dynamic var minTimeShip:Date = Date()
    dynamic var maxTimeShip:Date = Date()
    // tao them nhung thang khac
    override init() {
        
    }
    override class func primaryKey() -> String? {
        return "oderId"
    }
    
}
