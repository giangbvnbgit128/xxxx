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
import DateTimePicker

class SPAddProductViewController: SPBaseParentViewController, UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    @IBOutlet weak var txtfNameProduct: UITextField!
    @IBOutlet weak var txtfProducer: UITextField!
    @IBOutlet weak var txtfTotal: UITextField!
    @IBOutlet weak var txtfOriginPrice: UITextField!
    @IBOutlet weak var txtfPrice: UITextField!
    @IBOutlet weak var imgAvartaForProduct: UIImageView!
    @IBOutlet weak var parentPickerView: UIView!
    @IBOutlet weak var childPickerView: UIView!
    @IBOutlet weak var viewClosePickDateTime: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnDateTime: UIButton!
    @IBOutlet weak var txtfUnit: UITextField!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var lblunitForOriginPrice: UILabel!

    @IBOutlet weak var lblUnitSalePrice: UILabel!
    let imagePiker = UIImagePickerController()
    var imageUrlForAvarta:String = ""
    var result:String = ""
    var date:Date = Date()
    var formatter:DateFormatter = DateFormatter()
    var isEditFlag:Bool = false
    var productForEdit = SPProduct()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePiker.delegate = self
        SPTabbarViewController.ShareInstance.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.txtfUnit.delegate = self
        
        date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DATA.DATEFORMAT
        result = formatter.string(from: date)
        self.btnDateTime.setTitle(result, for: .normal)
        self.navigationItem.title = "Create Product"
        self.btnOk.setTitle("Save", for: .normal)
        if self.isEditFlag {
            self.btnOk.setTitle("Update", for: .normal)
            self.setRightBarIconParent()
            self.navigationItem.title = "Edit And Delete Product"
            self.txtfNameProduct.text = self.productForEdit.name
            self.txtfProducer.text = self.productForEdit.producer
            self.txtfTotal.text = "\(self.productForEdit.totalProduct)"
            self.txtfOriginPrice.text = "\(self.productForEdit.originPrice)"
            self.txtfPrice.text = "\(self.productForEdit.price)"
            self.result = formatter.string(from: self.productForEdit.startDate)
            self.btnDateTime.setTitle(self.result, for: .normal)
            self.txtfUnit.text = self.productForEdit.unit
            if let urlImage = URL(string: productForEdit.imageUrl) {
                let assets = PHAsset.fetchAssets(withALAssetURLs: [urlImage], options: nil)
                if let p = assets.firstObject {
                    self.imgAvartaForProduct.image = getAssetThumbnail(asset: p)
                }
            }

        }
  
    }
    
    override func clickRightButton() {
        self.showAlerComfirm(message: "Do yout want delete \(productForEdit.name) ?", title: "Comfirm") { (isDelete) in
            if isDelete {
                let realm = try! Realm()
                if let productForDelete = realm.objects(SPProduct.self).filter("id == \(self.productForEdit.id)").first {
                    try! realm.write {
                        realm.delete(productForDelete)
                    }
                }
                self.navigationController?.popViewController(animated: true)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickCancel(_ sender: Any) {
        self.txtfNameProduct.text = ""
        self.txtfProducer.text = ""
        self.txtfTotal.text = ""
        self.txtfOriginPrice.text = ""
        self.txtfPrice.text = ""
        self.date = Date()
        self.result = formatter.string(from: date)
        self.btnDateTime.setTitle(self.result, for: .normal)
        self.txtfUnit.text = ""
    }
    @IBAction func clickOk(_ sender: Any) {
        let nameProudct:String = self.txtfNameProduct.text ?? ""
        let producer:String = self.txtfProducer.text ?? ""
        let totalProduct:String = self.txtfTotal.text ?? ""
        let originPrice:String = self.txtfOriginPrice.text ?? ""
        let price:String = self.txtfPrice.text ?? ""
        let unit:String = self.txtfUnit.text ?? ""
        
        if nameProudct == "" {
            self.showAler(message: "Product name not null", title: "Error")
            return
        } else if totalProduct == ""{
            self.showAler(message: "Total product not null", title: "Error")
            return
        } else if originPrice == "" {
            self.showAler(message: "Origin price not null", title: "Error")
            return
        }
        
        // total ,  price and savePrice
        
        
        
        let product = SPProduct()
        product.id = product.incrementID(modelName: SPProduct.self)
        product.name = nameProudct
        if let total = Int(totalProduct) {
           product.totalProduct = total
        } else {
            self.showAler(message: "Total product not avalible", title: "Error")
        }
        product.imageUrl = self.imageUrlForAvarta
        product.producer = producer
        if let oriPrice = Int(originPrice) {
            product.originPrice = oriPrice
        } else {
            self.showAler(message: "Origin price not avalible", title: "Error")
        }
        
        if let salePrice = Int(price) {
            product.price = salePrice
        } else {
            self.showAler(message: "Sale price not avalible", title: "Error")
        }
        product.inventory = 0
        product.startDate = self.date
        product.unit = unit
        
        let realm = try! Realm()
        
        if self.isEditFlag {
            let productForUpdate = realm.objects(SPProduct.self).filter("id == \(productForEdit.id)").first
            try! realm.write {
                productForUpdate?.name = nameProudct
                productForUpdate?.totalProduct = Int(totalProduct) ?? 0
                productForUpdate?.imageUrl = self.imageUrlForAvarta
                productForUpdate?.producer = producer
                productForUpdate?.originPrice = Int(originPrice) ?? 0
                productForUpdate?.price = Int(price) ?? 0
                productForUpdate?.inventory = 0
                productForUpdate?.startDate = self.date
                productForUpdate?.unit = unit
            }
            
            
        } else {
            try! realm.write {
               realm.add(product)
            }
        }


        self.showAlerSuccess(message: "Add Product \(product.name) success !", title: "Done", buttonTitle: "Ok") { 
            self.navigationController?.popViewController(animated: true)
        }
        
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
                self.imageUrlForAvarta = String(describing: imageUrl)
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
    
    @IBAction func clickDateTimePicker(_ sender: Any) {

        let picker = DateTimePicker.show(selected: date, minimumDate: nil, maximumDate: nil)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.isDatePickerOnly = false // to hide time and show only date picker
        picker.selectedDate = date
        picker.dateFormat = DATA.DATEFORMAT
        picker.completionHandler = { date in
            self.date = date
            DispatchQueue.main.async {
                self.formatter.dateFormat = DATA.DATEFORMAT
                self.result = self.formatter.string(from: date)
                self.btnDateTime.setTitle(self.result, for: .normal)
                self.btnDateTime.titleLabel?.textColor = .red
            }

        }
    }

}

extension SPAddProductViewController: UITextFieldDelegate {

    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == self.txtfUnit {
            self.lblUnitSalePrice.text = textField.text
            self.lblunitForOriginPrice.text = textField.text
        }

    }
    
}
