//
//  SPOrderViewController.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/7/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit
import RealmSwift

class SPOrderViewController: SPBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnMaps: UIButton!

    let heightForCell:CGFloat = 202
    
    var arrayOrder:[SPOrderModel] = []
    var arrayProduct:[SPProduct] = []
    
    struct Static {
        static var instance: SPOrderViewController?
    }
    
    class var ShareInstance: SPOrderViewController {
        if Static.instance == nil {
            Static.instance = SPOrderViewController()
        }
        return Static.instance!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCellNib(SPRecipentTableViewCell.self)
        tableView.separatorStyle = .none
        Static.instance = self
        
        // configMenu
        
        self.btnMaps.layer.cornerRadius = self.btnMaps.layer.frame.width/2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // load data
        
    }
    
    override func getData() {
        if tableView != nil {
            let realm = try! Realm()
            let oders = realm.objects(SPOrderModel.self)
            let products = realm.objects(SPProduct.self)
            self.arrayOrder = Array(oders).reversed()
            self.arrayProduct = Array(products)
            
            tableView.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickMenuMaps(_ sender: Any) {
        let mapsVC = SPMapsViewController()
        mapsVC.isAllMaps = true
        mapsVC.arrayPoint = self.arrayOrder
        SPTabbarViewController.ShareInstance.navigationController?.pushViewController(mapsVC, animated: true)
    }
}
extension SPOrderViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SPRecipentTableViewCell.self)
        let order = arrayOrder[indexPath.row]
        cell.configCell(index: indexPath.row, order: order)
        return cell
    }
}
extension SPOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightForCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // truyen sang ben kia 1 orderItem
        
        let viewVC = SPAddOrderViewController()
        viewVC.isShowDetail = true
        viewVC.orderDetail = arrayOrder[indexPath.row]
        SPTabbarViewController.ShareInstance.navigationController?.pushViewController(viewVC, animated: true)
    }
}
