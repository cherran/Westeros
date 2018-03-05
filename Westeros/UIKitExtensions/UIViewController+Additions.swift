//
//  UIViewController+Additions.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 5/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

// Para evitar hacer esto todo el rato:
//   let starkNavigationController = UINavigationController(rootViewController: starkHouseViewController)
// Y poder hacer esto simplemente:
//   let starkNavigationController = starkHouseViewController.wrappedInNavigation()
