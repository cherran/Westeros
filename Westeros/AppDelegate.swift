//
//  AppDelegate.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 15/2/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? // ventana de la app


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Si hay backgroundColor en window, accede a ella, si no no hagas nada
        // desempaqueta el opcional si existe tal propiedad, igual con los métodos
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()
        
        
        // Creamos el modelo
        let houses = Repository.local.houses
        
        
        // Creamos los controladores
//        let controllers = houses.map{ HouseDetailViewController(model: $0).wrappedInNavigation() }
        
//        let controllers = houses.map{ house in
//            return HouseDetailViewController(house).wrappedInNavigation
//        }

//        var controllers = [UIViewController]() // Así cremos un array vacío
//        for house in houses {
//            controllers.append(HouseDetailViewController(model: house).wrappedInNavigation())
//            // Podemos hacer esto aunque el array sea de UIViewControllers ya que UINavigationController es subclase de UIViewController
//        }
        
        
        // Creamos los combinadores (UITabBarController)
//        let tabBarViewController = UITabBarController()
//        tabBarViewController.viewControllers = houses
//            .map{ HouseDetailViewController(model: $0) }
//            .map{ $0.wrappedInNavigation() }
        
        
        // Creamos los controladores (masterVC, detailVC)
        let houseListViewController = HouseListTableViewController(model: houses)
        
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        
        // Asignamos delegados
        houseListViewController.delegate = houseDetailViewController
        
        // Crear  el UISplitVC y le asignamos los viewControllers (master y detail)
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            houseListViewController.wrappedInNavigation(),
            houseDetailViewController.wrappedInNavigation()
        ]
        
        // Asignamos el rootVC
        window?.rootViewController = splitViewController
        
        return true
    }

    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

