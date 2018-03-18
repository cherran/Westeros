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
    
    var tabBarViewController: UITabBarController!
    var splitViewController: UISplitViewController!
    
    var houseListViewController: HouseListTableViewController!
    var houseDetailViewController: HouseDetailViewController!
    var seasonListViewController: SeasonListViewController!
    var seasonDetailViewController: SeasonDetailViewController!
    
    var houseListNavigation: UINavigationController!
    var houseDetailNavigation: UINavigationController!
    var seasonListNavigation: UINavigationController!
    var seasonDetailNavigation: UINavigationController!
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Si hay backgroundColor en window, accede a ella, si no no hagas nada
        // desempaqueta el opcional si existe tal propiedad, igual con los métodos
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()
        
        
        // Creamos los modelo
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        
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
        
        
        // Creamos los controladores
        houseListViewController = HouseListTableViewController(model: houses)
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        
        seasonListViewController = SeasonListViewController(model: seasons)
        seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        // Asignamos delegados
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        
        // Los envolvemos en Navigations
        houseListNavigation = houseListViewController.wrappedInNavigation()
        houseDetailNavigation = houseDetailViewController.wrappedInNavigation()
        seasonListNavigation = seasonListViewController.wrappedInNavigation()
        seasonDetailNavigation = seasonDetailViewController.wrappedInNavigation()
        
        
        // tabBar
        let tabBarViewController = UITabBarController()
        tabBarViewController.delegate = self
        tabBarViewController.viewControllers = [houseListNavigation, seasonListNavigation]
        tabBarViewController.title = "Westeros"
        
        
        // Crear  el UISplitVC y le asignamos los viewControllers (master y details)
        splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            tabBarViewController,
            houseDetailNavigation,
            seasonDetailNavigation
            
        ]
        
//        [houseDetailViewController, seasonDetailViewController].forEach {
//            $0.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
//        }
        
        
        window?.rootViewController = splitViewController
//        window?.rootViewController = seasonDetailViewController.wrappedInNavigation()
        
        
        return true
    }

}


extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewController as? UINavigationController,
                    let viewController = navigationController.viewControllers.first else { return }
        
                let detailNavigation: UINavigationController
                if type(of: viewController ) == SeasonListViewController.self {
                    detailNavigation = seasonDetailNavigation
                } else {
                    detailNavigation = houseDetailNavigation
                }
                print(detailNavigation)
        
                splitViewController.viewControllers[1] = detailNavigation
        
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            splitViewController.showDetailViewController(detailNavigation, sender: nil)
        //        }
    }
}


