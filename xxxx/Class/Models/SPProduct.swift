//
//  SPProduct.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import RealmSwift
import Realm

class SPCategoryProduct: Object {
   dynamic var id:Int = -1
   dynamic var inventory:Int = 0
   dynamic var totalProduct:Int = 0
   dynamic var name:String = ""
   dynamic var imageUrl:String = ""
   dynamic var price:Int = 0
   dynamic var originPrice:Int = 0
   dynamic var startDate:String = ""
   dynamic var endDate:String = ""
   dynamic var producer:String = ""
   
}


class SPProduct: SPCategoryProduct {
//    var gourp:[SPCategoryProduct] = []
    
}
