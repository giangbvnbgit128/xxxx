//
//  SPAddProductViewController.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit
import RealmSwift
import Photos

class SPAddProductViewController: SPBaseParentViewController, UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    @IBOutlet weak var txtfNameProduct: UITextField!
    @IBOutlet weak var txtfProducer: UITextField!
    @IBOutlet weak var txtfTotal: UITextField!
    @IBOutlet weak var txtfOriginPrice: UITextField!
    @IBOutlet weak var txtfPrice: UITextField!
    @IBOutlet weak var imgAvartaForProduct: UIImageView!

    let imagePiker = UIImagePickerController()
    
    var imageInfor:[String : Any] = [:]
    var imagesList = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePiker.delegate = self
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
        let product = SPProduct()
            product.name = nameProudct
            product.totalProduct = 100
            product.imageUrl = ""//imageInfor
            product.producer = producer
            product.originPrice = 100
            product.price = Int(price) ?? 0
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
    // laod image from ablum
        imagePiker.allowsEditing = false
        imagePiker.sourceType = .photoLibrary
        
        present(imagePiker, animated: true, completion: nil)
    }
    @IBAction func clickUini(_ sender: Any) {
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // save a PHAsset reference in imagesList array for later use
        if let imageUrl = info[UIImagePickerControllerReferenceURL] as? URL{
            
            let assets = PHAsset.fetchAssets(withALAssetURLs: [imageUrl], options: nil)
            
            if let p = assets.firstObject {
                
//                imagesList.append(p)
                self.imgAvartaForProduct.image = getAssetThumbnail(asset: p)
                
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

