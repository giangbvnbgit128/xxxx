//
//  AVBaseViewController.swift
//  AnViet
//
//  Created by Bui Giang on 5/25/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class SPBaseViewController: SPBaseParentViewController{
    class var identifier: String { return String.className(self) }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(indicator)
        self.view.bringSubview(toFront: indicator)
        self.indicator.backgroundColor = UIColor.clear
        self.indicator.frame = CGRect( x: UIScreen.main.bounds.width/2 - 25, y: UIScreen.main.bounds.height/2 - 25 - self.heightStatusBar() - 55, width: 50, height: 50)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
    }
    
    func getData() {
        
    }
    
    func isHiddenNavigationBar(isHidden:Bool) {
        self.navigationController?.isNavigationBarHidden = isHidden
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func showAler(message:String,title:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
}
