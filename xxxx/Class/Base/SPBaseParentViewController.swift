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
}
