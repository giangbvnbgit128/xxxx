//
//  SPOrderModel.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import Foundation

class Location {
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    init() {
    }
    init(latitude:Double, longitude:Double) {
        
        self.latitude = latitude
        self.longitude = longitude
    }
}

class SPOrderModel: NSObject {
    var nameGuest:String = ""
    var phoneNumber:String = ""
    var address:String = ""
    var product:SPProduct = SPProduct()
    var des:String = ""
    var paid:Bool = false
    var categoryId:Int = -1
    var categoryName:String = ""
    var location:Location = Location()
    
    override init() {
    }
    
    
}
