//
//  SPAddOrderViewController.swift
//  xxxx
//
//  Created by Bui Giang on 9/14/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit

class SPAddOrderViewController: SPBaseParentViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SPTabbarViewController.ShareInstance.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.setRightBarIconParent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clickRightButton() {
        self.navigationController?.popViewController(animated: true)
    }

}
