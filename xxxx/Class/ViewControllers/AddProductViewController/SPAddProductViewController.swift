//
//  SPAddProductViewController.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit
import RealmSwift

class SPAddProductViewController: SPBaseParentViewController {
    
    @IBOutlet weak var txtfNameProduct: UITextField!
    @IBOutlet weak var txtfProducer: UITextField!
    @IBOutlet weak var txtfTotal: UITextField!
    @IBOutlet weak var txtfOriginPrice: UITextField!
    @IBOutlet weak var txtfPrice: UITextField!
    @IBOutlet weak var imgAvartaForProduct: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickCancel(_ sender: Any) {
        
    }
    @IBAction func clickOk(_ sender: Any) {
        let nameProudct:String = self.txtfNameProduct.text ?? ""
        let producer:String = self.txtfProducer.text ?? ""
        let totalProduct:String = self.txtfTotal.text ?? ""
        let originPrice:String = self.txtfOriginPrice.text ?? ""
        let price:String = self.txtfPrice.text ?? ""
        let imageUrl:String = ""
        
        if nameProudct == "" {
            self.showAler(message: "Product name not null", title: "Error")
            return
        } else if totalProduct == "" {
            self.showAler(message: "Total product not null", title: "Error")
            return
        } else if originPrice == "" {
            self.showAler(message: "Origin price not null", title: "Error")
            return
        }
        // func save data
        /*
         var id:Int = -1
         var inventory:Int = 0
         var totalProduct:Int = 0
         var name:String = ""
         var imageUrl:String = ""
         var price:Int = 0
         var originPrice:Int = 0
         var startDate:String = ""
         var endDate:String = ""
         var producer:String = ""

         */
        var product = SPProduct()
            product.name = nameProudct
            product.totalProduct = 100
            product.imageUrl = ""
            product.producer = producer
            product.originPrice = 100
            product.price = 100
            product.totalProduct = 100
            product.inventory = 0
            product.startDate = "12345"
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(product)
        }
        self.showAler(message: "Add Product \(product.name) success !", title: "Done")
    }
    @IBAction func clickSelectImage(_ sender: Any) {
    
    }
    @IBAction func clickUini(_ sender: Any) {
        
    }

}
