//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 15/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

// MARK: - SeasonListViewControllerDelegate
protocol SeasonListViewControllerDelegate: class {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season)
}


class SeasonListViewController: UITableViewController {
    // Mark: - Properties
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [Season]) {
        self.model = model
        super.init(style: .plain)
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        
        // Descubrir cuál es la temporada que tenemos que mostrar
        let season = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) // Comprobar si hay alguna cacheada que se pueda reutilizar
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Texto de la celda
        cell?.textLabel?.text = season.name
        
        // Texto detallado (fecha de emisión)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, y"
        let date = dateFormatter.string(from: season.airDate)
        cell?.detailTextLabel?.text = "First Aired: \(date)"
        
        return cell!
    }
    
    
    // Mark: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = model[indexPath.row]
        
        // Creo la vista detallada
        let seasonDetailView = SeasonDetailViewController(model: season)
        
        // Hago un push de la vista detallada
        navigationController?.pushViewController(seasonDetailView, animated: true)
        
        // Aviso al delegado
        // delegate?.seasonListViewController(self, didSelectSeason: season)
    }
    
    
}





