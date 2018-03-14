//
//  HouseListTableViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 7/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

let HOUSE_DID_CHANGE_NOTIFICATION_NAME = "HouseDidChange"
let HOUSE_KEY = "HouseKey"
let LAST_HOUSE = "LAST_HOUSE"

protocol HouseListTableViewControllerDelegate: class {
    // should, will, did
    func houseListViewController(_ viewController: HouseListTableViewController, didSelectHouse: House)
}


class HouseListTableViewController: UITableViewController {
    
    // Mark: - Properties
    let model: [House]
    weak var delegate: HouseListTableViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [House]) {
        self.model = model
        super.init(style: .plain)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastRow = UserDefaults.standard.integer(forKey: HOUSE_KEY)
        let indexPath = IndexPath(row: lastRow, section: 0)
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    
    
    // MARK: - Table view data source
    // Para conformarse al protocolo UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "HouseCell"
        
        // Descubrir cuál es la casa que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) // Comprobar si hay alguna cacheada que se pueda reutilizar
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar house(model) con cell (vista)
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name
        
        return cell!
    }
    
    
    // Mark: - Table View Delegate
    // Los delegados por convención cuentan todo el proceso de algo:
    // should, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar qué casa han pulsado
        let house = model[indexPath.row]
        
        // Crear un controlador de detalle de esa casa
//        let houseDetailViewController = HouseDetailViewController(model: house)
//
//        // Hacer un push
//        navigationController?.pushViewController(houseDetailViewController, animated: true)
        
        
        // Avisamos al delegado
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Mando la misma info a través de notificaciones
        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY : house])
        
        notificationCenter.post(notification)
        
        // Guardamos las coordenadas (section, row) de la última casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
}
extension HouseListTableViewController {
    func saveLastSelectedHouse(at row: Int) {
        let defaults = UserDefaults.standard
        
        defaults.set(row, forKey: LAST_HOUSE)
        defaults.synchronize() // Por si las moscas
    }
    
    func lastSelectedHouse() -> House {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        
        // Averiguar la casa de ese row
        let house = model[row]
        
        // Devolverla
        return house
    }
}










