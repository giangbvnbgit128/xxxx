//
//  AppDelegate.swift
//  xxxx
//
//  Created by Bui Van Giang on 9/7/17.
//  Copyright © 2017 Bui Van Giang. All rights reserved.
//

import UIKit
import AKSideMenu
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // setup For GoogleMaps
        
        GMSServices.provideAPIKey(DATA.APIKEYMAPS)
        GMSPlacesClient.provideAPIKey(DATA.APIKEYMAPS)
        
        
        let leftSlideMenu = SPLeftMeuViewController.vc()
        let tabbarControler = SPTabbarViewController.vc()
        
        let navTabbar = SPBaseNavigationController(rootViewController: tabbarControler)
        let rootView:AKSideMenu = AKSideMenu(contentViewController: navTabbar, leftMenuViewController: leftSlideMenu, rightMenuViewController: nil)
        
        self.window?.rootViewController = rootView
        self.window?.backgroundColor = UIColor.clear
        self.window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }


}

