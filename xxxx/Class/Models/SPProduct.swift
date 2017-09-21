//
//  SPProduct.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import RealmSwift
import Realm

class SPCategoryProduct: SPBaseModelRealm {
   dynamic var inventory:Int = 0
   dynamic var totalProduct:Int = 0
   dynamic var name:String = ""
   dynamic var imageUrl:String = ""
   dynamic var price:Int = 0
   dynamic var originPrice:Int = 0
   dynamic var startDate:Date = Date()
   dynamic var endDate:Date = Date()
   dynamic var producer:String = ""
   dynamic var unit:String = ""
   
}


class SPProduct: SPCategoryProduct {


}
