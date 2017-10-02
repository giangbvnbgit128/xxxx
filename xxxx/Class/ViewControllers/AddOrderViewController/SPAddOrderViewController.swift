//
//  SPAddOrderViewController.swift
//  xxxx
//
//  Created by Bui Giang on 9/14/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit
import GooglePlaces
import RealmSwift
import DateTimePicker

class SPAddOrderViewController: SPBaseParentViewController {
    
    let heightForAlerViewCoordinate:CGFloat = 186
    var heightForAlerViewCoordinateDefault:CGFloat = 130
    
    @IBOutlet weak var nscontraintHeightForAlerViewAddress: NSLayoutConstraint!
    @IBOutlet weak var viewCoordinate: UIView!
    @IBOutlet weak var btncloseAlertView: UIButton!
    @IBOutlet weak var txtfName: UITextField!
    @IBOutlet weak var txtfTotalProduct: UITextField!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var btnProduct: UIButton!
    @IBOutlet weak var lblTotalProduct: UILabel!
    @IBOutlet weak var txtvRs: UITextView!
    
    @IBOutlet weak var txtvResult: UITextView!
    
    @IBOutlet weak var btnSearchAdress: UIButton!
    
    @IBOutlet weak var viewAler: UIView!
    @IBOutlet weak var viewAlertChild: UIView!
    @IBOutlet weak var txtfLatitude: UITextField!
    @IBOutlet weak var txtfLongtitude: UITextField!
    
    @IBOutlet weak var txtfShip: UITextField!
    @IBOutlet weak var selectProductView: UIView!
    
    @IBOutlet weak var txtfPhoneNumber: UITextField!
    @IBOutlet weak var viewContentProduct: UIView!
    
    @IBOutlet weak var btnViewCloseSelectProduct: UIButton!
    
    @IBOutlet weak var pickerViewSelectProduct: UIPickerView!
    
    @IBOutlet weak var lblTotalTimeDistance: UILabel!
    var oldFrameAlert:CGRect = CGRect()
    var newFrameAlert:CGRect = CGRect()
    @IBOutlet weak var btnMinTimeShip: UIButton!
    var odlFrameForSelectProduct:CGRect = CGRect()
    
    var arrayProduct:[SPProduct] = []
    @IBOutlet weak var btnMaxTimeShip: UIButton!
    var address:SPAddress = SPAddress()
    var myLocation:SPAddress = SPAddress()
    var date:Date = Date()
    var formater:DateFormatter = DateFormatter()
    var dateforMinShip:Date = Date()
    var dateforMaxShip:Date = Date()
    var product:SPProduct = SPProduct()
    var indexForProduct:Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewSelectProduct.dataSource = self
        pickerViewSelectProduct.delegate = self
        
        SPTabbarViewController.ShareInstance.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.setRightBarIconParent()
        self.hiddenAlert()
        self.hiddenSelectProduct()
        self.hiddenViewCoordinateinPopupView()
        self.loadProduct()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hiddenViewCoordinateinPopupView()
        self.hiddenAlert();
        
    }
    
// MARK :- Select Time Ship
    @IBAction func clickSelectMaxTimeShip(_ sender: Any) {
        let picker = DateTimePicker.show(selected: date, minimumDate: nil, maximumDate: nil)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.isDatePickerOnly = false // to hide time and show only date picker
        picker.selectedDate = date
        picker.dateFormat = DATA.DATEFORMAT
        picker.completionHandler = { date in
            DispatchQueue.main.async {
                self.formater.dateFormat = DATA.DATEFORMAT
                self.dateforMaxShip = date
                let result:String = self.formater.string(from: date)
                self.btnMaxTimeShip.setTitle(result, for: .normal)
                
            }
            
        }
    }

    @IBAction func caculaterShip(_ sender: Any) {
        // show km time -> tien ship
        // caanf tryenf vao time so de request.
        
        SPMapsViewController.ShareInstance.getDetailRouter(starTime: self.myLocation, endTime: self.address) { (distance, duration) in
            var money:Float = 0
            
            money = Float(distance.Value)/1000 * 5000
            
             self.txtfShip.text = "Distance: \(distance.Text) Time: \(duration.Text) = \(money)$"
        }
        
       
        
    }
    
    @IBAction func clickMinTimeShip(_ sender: Any) {
        let picker = DateTimePicker.show(selected: date, minimumDate: nil, maximumDate: nil)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.isDatePickerOnly = false // to hide time and show only date picker
        picker.selectedDate = date
        picker.dateFormat = DATA.DATEFORMAT
        picker.completionHandler = { date in
            DispatchQueue.main.async {
                self.formater.dateFormat = DATA.DATEFORMAT
                self.dateforMinShip = date
                let result:String = self.formater.string(from: date)
                self.btnMinTimeShip.setTitle(result, for: .normal)
                
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clickRightButton() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickSelectProduct(_ sender: Any) {
        self.showSelectProduct()
    }
    
// MARK: - click Save Coordinate
    
    @IBAction func clickSaveCoordinate(_ sender: Any) {
    }
// MARK: - clickSave order
    
    @IBAction func clickOk(_ sender: Any) {
         let order = SPOrderModel()
        
        if let nameGuest:String = self.txtfName.text {
            order.nameGuest = nameGuest
        }
        
        if let phoneNumber = self.txtfPhoneNumber.text {
            order.phoneNumber = phoneNumber
        }
        if let product:SPProduct = self.arrayProduct[self.indexForProduct] {
            order.idProduct = product.id
        }
        
        if let totalProduct:Int =  Int(self.txtfTotalProduct.text ?? "0")  {
            order.totalProduct = totalProduct
        }
        // save adress . - > lay id luong
        self.address.id = self.address.incrementID(modelName: SPAddress.self)
        order.idAddress = self.address.id
        order.minTimeShip = self.dateforMinShip
        order.maxTimeShip = self.dateforMaxShip
        
        self.saveData(address: self.address, order: order)
        
        
    }
    
    func saveData(address:SPAddress, order: SPOrderModel) {
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(address)
            realm.add(order)
        }
        
        self.showAlerSuccess(message: "Thành công", title: "Tạo đơn hàng thành công", buttonTitle: "Ok") { 
             self.navigationController?.popViewController(animated: true)
        }

    }
    
    
    @IBAction func clickAddCoordinate(_ sender: Any) {
        self.showAlertCoordinate()
    }
  
    @IBAction func clickCLoseAlert(_ sender: Any) {
        self.dismissAler()
    }

    @IBAction func clickReset(_ sender: Any) {
        self.txtfName.text = ""
        self.txtfPhoneNumber.text = ""
        self.txtfLatitude.text = ""
        self.txtfLongtitude.text = ""
        self.txtfTotalProduct.text = "0"
        self.btnProduct.setTitle("Chọn sản phẩm", for: .normal)
        self.btnMinTimeShip.setTitle("Sớm nhất", for: .normal)
        self.btnMaxTimeShip.setTitle("Muộn nhất", for: .normal)
        self.btnSearchAdress.setTitle("Tìm Địa chỉ", for: .normal)
        self.lblDistance.text = ""
        self.lblTotalTimeDistance.text = "--"
        self.txtvRs.text = ""
        
    }
// MARK: - Search Click address
    @IBAction func clickSearchAddress(_ sender: Any) {
        
        self.showAlertCoordinate()

    }

    @IBAction func clickSearchAddressWithMaps(_ sender: Any) {
        let SPMapsVC = SPMapsViewController()
            SPMapsVC.blockCompleteUpdateAdress = {(place, mylocation) in
            print("place in name = \(place.name)")// minh lay dc toan do ten vi tri.
            self.address.nameAddress = place.name
            self.address.distance = 0
            self.address.latitude = place.coordinate.latitude
            self.address.longitude = place.coordinate.longitude
            self.myLocation = mylocation
            }
            SPTabbarViewController.ShareInstance.navigationController?.pushViewController(SPMapsVC, animated: true)
    }
    @IBAction func addAddressWithCoordinate(_ sender: Any) {
        self.viewCoordinate.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
        self.nscontraintHeightForAlerViewAddress.constant = self.heightForAlerViewCoordinate
          self.viewCoordinate.alpha = 1
        }) { (complete) in
            //
        }
    }

    @IBAction func clickCloseSelectProduct(_ sender: Any) {
        
        self.dismissSelectProduct()
    }
//Mark: - Ok and Canecl Select product
    @IBAction func clickCancelProduct(_ sender: Any) {
        self.dismissSelectProduct()
    }
    @IBAction func clickOkProduct(_ sender: Any) {
        if let product:SPProduct = arrayProduct[self.indexForProduct] {
            self.btnProduct.setTitle(product.name, for: .normal)
            self.txtfTotalProduct.text = "\(product.totalProduct - product.inventory)"
            self.txtfTotalProduct.becomeFirstResponder()
            self.product = product
        }
        self.dismissSelectProduct()

    }
    
 
}

extension SPAddOrderViewController {
    func dismissAler() {
        self.btncloseAlertView.alpha = 0
        self.newFrameAlert.origin.y = UIScreen.main.bounds.width * -1
        UIView.animate(withDuration: 0.5, animations: {
            self.viewAlertChild.frame.origin.x = -1 * UIScreen.main.bounds.width
        }) { (complete) in
            if complete {
                self.hiddenAlert()
                self.hiddenViewCoordinateinPopupView()
            }
        }
    }
    
    func showAlertCoordinate()  {
        self.viewAler.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.viewAlertChild.frame.origin.x = (UIScreen.main.bounds.width - (self.viewAlertChild.frame.width))/2
        }) { (complete) in
            if complete {
                self.btncloseAlertView.alpha = 0.3
            }
        }
    }
    
// Mark: - dismiss alertview
    
    func hiddenAlert() {
        
        self.viewAler.isHidden = true
        self.btncloseAlertView.alpha = 0
        self.oldFrameAlert = self.viewAlertChild.frame
        self.newFrameAlert = self.oldFrameAlert
        self.newFrameAlert.origin.x = UIScreen.main.bounds.width
        DispatchQueue.main.async {
            self.viewAlertChild.frame.origin.x = UIScreen.main.bounds.width
        }
        
        
    }
    func hiddenViewCoordinateinPopupView() {
        self.viewCoordinate.alpha = 0
        self.nscontraintHeightForAlerViewAddress.constant = self.heightForAlerViewCoordinateDefault
        self.viewCoordinate.isHidden = true
    }
    
    func loadProduct() {
        if pickerViewSelectProduct != nil {
            let realm = try! Realm()
            let puppies = realm.objects(SPProduct.self)
            self.arrayProduct = Array(puppies).reversed()
            pickerViewSelectProduct.reloadAllComponents()
        }
    }
}

extension SPAddOrderViewController: UIPickerViewDataSource , UIPickerViewDelegate{ // for select Product
    func hiddenSelectProduct()  {
        self.selectProductView.isHidden = true
        self.btnViewCloseSelectProduct.alpha = 0
        self.odlFrameForSelectProduct = self.viewContentProduct.frame
        DispatchQueue.main.async {
            self.viewContentProduct.frame.origin.y = UIScreen.main.bounds.height
        }

    }
    
    func showSelectProduct() {
        
        self.selectProductView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.viewContentProduct.frame.origin.y = (UIScreen.main.bounds.height/5) * 3
            print("frame for viewContend = \(self.viewContentProduct.frame)")
        }) { (complete) in
            if complete {
                self.btnViewCloseSelectProduct.alpha = 0.3
            }
        }
        
    }
    
    func dismissSelectProduct() {
        self.btnViewCloseSelectProduct.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.viewContentProduct.frame.origin.y = UIScreen.main.bounds.height
        }) { (complete) in
            if complete {
                self.hiddenSelectProduct()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrayProduct.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(arrayProduct[row].name)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // select row.
        self.indexForProduct = row

    }
    
}


