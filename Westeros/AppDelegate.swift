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

        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Si hay backgroundColor en window, accede a ella, si no no hagas nada
        // desempaqueta el opcional si existe tal propiedad, igual con los métodos
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()
        
        
        // Creamos los modelo
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        
        // Creamos los controladores
        houseListViewController = HouseListTableViewController(model: houses)
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        
        seasonListViewController = SeasonListViewController(model: seasons)
        seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        // Asignamos delegados
        if UIDevice.current.userInterfaceIdiom == .pad {
            houseListViewController.delegate = houseDetailViewController
            seasonListViewController.delegate = seasonDetailViewController
        } else {
            houseListViewController.delegate = houseListViewController
            seasonListViewController.delegate = seasonListViewController
        }
        
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
            houseDetailNavigation
        ]
        

        window?.rootViewController = splitViewController

        
        
        return true
    }

}


extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first else { return }
        
        let detailView: UINavigationController
        if type(of: viewController ) == SeasonListViewController.self {
            detailView = seasonDetailNavigation
        } else {
            detailView = houseDetailNavigation
        }
        
        // Si estoy en un Ipad tengo que cambiar la vista detallada del splitview (seasons o houses)
        if UIDevice.current.userInterfaceIdiom == .pad {
            splitViewController.viewControllers[1] = detailView
        }
    }
}


