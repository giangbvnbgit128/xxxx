//
//  SPOrderViewController.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/7/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit

class SPOrderViewController: SPBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnMaps: UIButton!
    
    let heightForCell:CGFloat = 202
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCellNib(SPRecipentTableViewCell.self)
        tableView.separatorStyle = .none
        
        // configMenu
        
        self.btnMaps.layer.cornerRadius = self.btnMaps.layer.frame.width/2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickMenuMaps(_ sender: Any) {
        let mapsVC = SPMapsViewController()
        SPTabbarViewController.ShareInstance.navigationController?.pushViewController(mapsVC, animated: true)
    }
}
extension SPOrderViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SPRecipentTableViewCell.self)
        cell.configCell(index: indexPath.row)
        return cell
    }
}
extension SPOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightForCell
    }
}
