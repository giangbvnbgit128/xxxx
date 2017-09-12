//
//  SPManagerProductViewController.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit
import RealmSwift


class SPManagerProductViewController: SPBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let heightForCell:CGFloat = 120
    var arrayProduct:[SPProduct] = []
    
    struct Static {
        static var instance: SPManagerProductViewController?
    }
    class var ShareInstance: SPManagerProductViewController {
        if Static.instance == nil {
            Static.instance = SPManagerProductViewController()
        }
        return Static.instance!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCellNib(SPProductTableViewCell.self)
        Static.instance = self
        if tableView != nil {
            self.loadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func loadData() {
        if tableView != nil {
            let realm = try! Realm()
            let puppies = realm.objects(SPProduct.self)
            self.arrayProduct = Array(puppies).reversed()
            print("Puppies = \(puppies.count)")
            tableView.reloadData()
        }
    }
}
extension SPManagerProductViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SPProductTableViewCell.self)
        cell.ConfigCell(product: arrayProduct[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SPManagerProductViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightForCell
    }
    
}
