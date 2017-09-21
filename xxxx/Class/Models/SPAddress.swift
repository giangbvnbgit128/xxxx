//
//  SPAddress.swift
//  xxxx
//
//  Created by Bui Giang on 9/17/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import Foundation
import RealmSwift

class SPAddress: SPBaseModelRealm{
    dynamic var nameAddress:String = ""
    dynamic var latitude:Double = 0.0
    dynamic var longitude:Double = 0.0
    dynamic var distance:Float = Float()
    dynamic var time:Float = Float()

}
