//
//  SPTabbarViewController.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/7/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit

enum indexTabbar:Int  {
    case orderTabbar = 0
    case billTabbar = 1
    case productTabbar = 2
    case frequenterTabbar = 3
}

class SPTabbarViewController: UIViewController {
    var pageMenu:CAPSPageMenu?
    @IBOutlet weak var tabbarView: UITabBar!
    @IBOutlet weak var orderItemTabbar: UITabBarItem!
    @IBOutlet weak var billItemTabbar: UITabBarItem!
    @IBOutlet weak var frequenterItemTabbar: UITabBarItem!
    @IBOutlet weak var mapsItemTabbar: UITabBarItem!
    @IBOutlet weak var productItemTabbar: UITabBarItem!
    
    var flagMove:Bool = true
    var tabbarIndex:indexTabbar = indexTabbar.orderTabbar
    
    struct Static {
        static var instance: SPTabbarViewController?
    }
    class var ShareInstance: SPTabbarViewController {
        if Static.instance == nil {
            Static.instance = SPTabbarViewController()
        }
        return Static.instance!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configTabbar
        tabbarView.delegate = self
        tabbarView.selectedItem = orderItemTabbar
        
        self.setUpTabBar()
        self.setRightBarIconParent()
        self.setLeftBarIconParent()

        
        Static.instance = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationItem.title = "Create Product"
        self.navigationItem.title = "aaaa"
        SPManagerProductViewController.ShareInstance.loadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK:- SetUp PageMenu
    func setUpTabBar() {
        
            self.tabbarView.tintColor = UIColor.red
        
            let orderVC       = SPOrderViewController()
            let billVC        = SPBillViewController()
            let productVC     = SPManagerProductViewController()
            let frequenterVC  = SPFrequenterViewController()
            let controllerArray = [ SPBaseNavigationController(rootViewController: orderVC),
                                    SPBaseNavigationController(rootViewController: billVC),
                                    SPBaseNavigationController(rootViewController: productVC),
                                    SPBaseNavigationController(rootViewController: frequenterVC)]
            let parameters: [CAPSPageMenuOption] = [
                    .scrollMenuBackgroundColor(UIColor(hex: "313131")),
                    .viewBackgroundColor(UIColor.white),
                    .selectionIndicatorColor(UIColor(hex: "13b2e2")),
                    .selectedMenuItemLabelColor(UIColor(hex: "13b2e2")),
                    .addBottomMenuHairline(true),
                    .menuItemFont(CCFont(.HiraKakuPro, .W6, 10)),
                    .menuHeight(0),
                    .selectionIndicatorHeight(0.0),
                    .selectionIndicatorHeight(2.0),
                    .bottomMenuHairlineColor(UIColor.clear),
                    .centerMenuItems(true),
                    .menuItemWidth(UIScreen.mainWidth/6),
                    .menuMargin(1),
                    .menuItemMargin(1)
                ]
        
            let heightTopView = self.heightStatusBar() + (navigationController?.navigationBar.frame.height ?? 0)
            let framePapeMenu = CGRect(x: 0, y: heightTopView, width: self.view.bounds.width, height: self.view.bounds.height - self.tabbarView.frame.height - heightTopView)
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: framePapeMenu, pageMenuOptions: parameters)
                pageMenu?.delegate = self
            pageMenu?.view.backgroundColor = UIColor.yellow
        
            if let pageMenu = pageMenu {
                    self.view.addSubview(pageMenu.view)
            }
    
    }
    
    // MARK: - Setup Left and Right
    func setRightBarIconParent() {
        let leftButton = UIButton(type: .custom)
        leftButton.addTarget(self, action: #selector(self.clickRightButtom), for: .touchUpInside)
        leftButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        leftButton.setImage(UIImage(named: "menu_button"), for: .normal)
        leftButton.contentMode = .scaleAspectFit
        let leftView = UIView(x: 0, y: 0, width: 32, height: 32)
        leftView.backgroundColor = .red
        leftView.addSubview(leftButton)
        let rightBarButton = UIBarButtonItem(customView: leftView)
        navigationItem.setLeftBarButton(rightBarButton, animated: true)
        
    }
    
    func setLeftBarIconParent() {
        let leftButton = UIButton(type: .custom)
        leftButton.addTarget(self, action: #selector(self.clickLeftButtom), for: .touchUpInside)
        leftButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        leftButton.setImage(UIImage(named: "menu_button"), for: .normal)
        leftButton.contentMode = .scaleAspectFit
        let leftView = UIView(x: 0, y: 0, width: 32, height: 32)
        leftView.backgroundColor = .red
        leftView.addSubview(leftButton)
        let rightBarButton = UIBarButtonItem(customView: leftView)
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        
    }
    
    func clickRightButtom()  {
        self.sideMenuViewController?.presentLeftMenuViewController()
    }
    func clickLeftButtom() {
        if (tabbarIndex == indexTabbar.productTabbar) && flagMove {
            let addVC = SPAddProductViewController()
            self.navigationController?.pushViewController(addVC, animated: true)
        }
        
    }
}

extension SPTabbarViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        pageMenu?.moveToPage(item.tag)
        self.flagMove = true
        switch item.tag {
        case indexTabbar.orderTabbar.rawValue:
            tabbarIndex = indexTabbar.orderTabbar
        case indexTabbar.billTabbar.rawValue:
            tabbarIndex = indexTabbar.billTabbar
        case indexTabbar.productTabbar.rawValue:
            tabbarIndex = indexTabbar.productTabbar
        case indexTabbar.frequenterTabbar.rawValue:
            tabbarIndex = indexTabbar.frequenterTabbar
        default:
            break
        }
        
    }
    
}

extension SPTabbarViewController: CAPSPageMenuDelegate {
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        flagMove = true
        switch index {
        case indexTabbar.orderTabbar.rawValue:
            tabbarView.selectedItem = orderItemTabbar
            tabbarIndex = indexTabbar.orderTabbar
        case indexTabbar.billTabbar.rawValue:
            tabbarView.selectedItem = billItemTabbar
            tabbarIndex = indexTabbar.billTabbar
        case indexTabbar.productTabbar.rawValue:
            tabbarView.selectedItem = productItemTabbar
            tabbarIndex = indexTabbar.productTabbar
        case indexTabbar.frequenterTabbar.rawValue:
            tabbarView.selectedItem = frequenterItemTabbar
            tabbarIndex = indexTabbar.frequenterTabbar
        default:
            break
        }
        
        pageMenu?.moveToPage(index)
    }
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
       self.flagMove = false
    }
}
