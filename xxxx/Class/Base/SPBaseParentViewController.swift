//
//  SPBaseParentViewController.swift
//  xxxx
//
//  Created by Bui Giang on 9/8/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit

class SPBaseParentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func showAler(message:String,title:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction( title: "Ok", style: .default, handler: { (complete) in
            print("Action Ok")
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func setRightBarIconParent() {
        let leftButton = UIButton(type: .custom)
        leftButton.addTarget(self, action: #selector(self.clickRightButton), for: .touchUpInside)
        leftButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        leftButton.setImage(UIImage(named: "buttondelete"), for: .normal)
        leftButton.contentMode = .scaleAspectFit
        let leftView = UIView(x: 0, y: 0, width: 32, height: 32)
        leftView.addSubview(leftButton)
        let rightBarButton = UIBarButtonItem(customView: leftView)
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        
    }
    
    func clickRightButton() {
        
    }
}
