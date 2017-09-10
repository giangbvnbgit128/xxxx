//
//  SPLeftMeuViewController.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/7/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit

enum indexCellLeftMenu:Int {
    case profile = 0
    case infor = 1
}

class SPLeftMeuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var nscontraintSpacingToRight: NSLayoutConstraint!
    @IBOutlet weak var nscontraintTopViewForLeftMenu: NSLayoutConstraint!
    
    var heightForProfileCell:CGFloat = 0
    let heightForInforCell:CGFloat = 68
    let heightForItemCell:CGFloat = 45
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nscontraintSpacingToRight.constant = setupSpacingRight()
        self.nscontraintTopViewForLeftMenu.constant = UIScreen.mainHeight * 0.1 * 0.5
        self.heightForProfileCell = 36 + self.heightStatusBar()
        // configTable
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCellNib(SPProfileTableViewCell.self)
        tableView.registerCellNib(SPInforTableViewCell.self)
        tableView.registerCellNib(SPItemLeftMenuTableViewCell.self)
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.clear
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSpacingRight() -> CGFloat {
        
        if ScreenSize.iSIPhone4OrLess {
            return 30
        } else if ScreenSize.IsIPhone5 {
            return 55
        } else if ScreenSize.IsIPhone6 {
            return 80
        } else {
            return 90 * Ratio.widthIPhone6
        }
        
    }

}

extension SPLeftMeuViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case indexCellLeftMenu.profile.rawValue:
            let cell = tableView.dequeue(SPProfileTableViewCell.self)
            return cell
        case indexCellLeftMenu.infor.rawValue:
            let cell = tableView.dequeue(SPInforTableViewCell.self)
            return cell
        default:
            let cell = tableView.dequeue(SPItemLeftMenuTableViewCell.self)
            return cell
        }
    }
}

extension SPLeftMeuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case indexCellLeftMenu.profile.rawValue:
            return self.heightForProfileCell
        case indexCellLeftMenu.profile.rawValue:
            return self.heightForInforCell
        default:
            return self.heightForInforCell
        }
    }
}
