//
//  Direction.swift
//  xxxx
//
//  Created by Bui Giang on 11/1/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import Foundation

class Direction {
    var arrayMyPoint:[SPOrderModel] = []
    var arrayPointMin:[SPOrderModel] = []
    
    init() {
    }
    

    
    func caculatorTowPoint(a:SPOrderModel , b:SPOrderModel) -> Float {
        return sqrt( pow(Float(a.latitude) - Float(b.latitude), 2) + pow((Float(a.longitude) - Float(b.longitude)), 2))
    }
    
    func findMinDistanceInArray(myPoint:SPOrderModel) -> SPOrderModel { // lay array ban dau lam goc
        if arrayMyPoint.count < 1 {
            
            return SPOrderModel()
        }
        var min:Float = caculatorTowPoint(a: myPoint, b: arrayMyPoint[0])
        var index:Int = 0
        for i in 0..<arrayMyPoint.count {
            let crMin = caculatorTowPoint(a: myPoint, b: arrayMyPoint[i])
            print("\(i) KHoang cach =tu \(myPoint.name) to \(arrayMyPoint[i].name) ==  \(crMin) count Aray = \(arrayMyPoint.count)")
            if min > crMin {
                min = crMin
                index = i
            }
        }
        print("Form \(myPoint.name)  to \(arrayMyPoint[index].name) distancMin = \(min)")
        return arrayMyPoint[index]
        
    }
    
    func findMinPoint(mylocation:SPOrderModel) {
        
        if arrayMyPoint.count == 1 {
            self.arrayPointMin.append(self.arrayMyPoint[0])
            print(self.arrayMyPoint[0].name)
            return
        } else {
            if arrayPointMin.count == 0 {
                let pointFirt:SPOrderModel = findMinDistanceInArray(myPoint: mylocation)
                arrayPointMin.append(pointFirt)
                print("mylocation = \(pointFirt.name)")
                self.removeArrayPointParentWithId(id: arrayPointMin.last?.id ?? 0)
            } else {
                arrayPointMin.append(findMinDistanceInArray(myPoint: arrayPointMin.last!))
                print("last = \(findMinDistanceInArray(myPoint: arrayPointMin.last!).name)")
                self.removeArrayPointParentWithId(id: arrayPointMin.last?.id ?? 0)
            }
            
            findMinPoint(mylocation: (arrayPointMin.last!))
            
        }
        
    }
    
    func removeArrayPointParentWithId(id:Int) {
        var indexRemove:Int = -1
        for i in 0..<self.arrayMyPoint.count {
            if self.arrayMyPoint[i].id == id {
                indexRemove = i
            }
        }
        
        if indexRemove != -1 {
            print("remove pHan tu == \(self.arrayMyPoint[indexRemove].name)")
            self.arrayMyPoint.remove(at: indexRemove)
            
        }else {
            
            print("hai cai id nay dang lech nhau \(id)")
        }
        
    }
    
    func initData(pointLocation:SPOrderModel , arrayMyPointFor:[SPOrderModel]) -> [SPOrderModel] {
        
        self.arrayMyPoint = arrayMyPointFor
        
        findMinPoint(mylocation: pointLocation)
        
        for i in 0..<self.arrayPointMin.count {
            print("i = \(i) myName = \(self.arrayPointMin[i].name)")
        }
        
        return self.arrayPointMin
    }

    
}
