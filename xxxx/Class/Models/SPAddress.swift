//
//  SPAddress.swift
//  xxxx
//
//  Created by Bui Giang on 9/17/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import Foundation
import RealmSwift

class SPAddress {
    dynamic var nameAddress:String = ""
    dynamic var location:Location = Location()
    dynamic var distance:Float = Float()
    dynamic var time:Float = Float()
    init() {
        
    }
}
