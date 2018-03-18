//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 15/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit


class EpisodeListViewController: UITableViewController {
    // Mark: - Properties
    var model: [Episode]

    
    // Mark: - Initialization
    init(model: [Episode]) {
        self.model = model
        super.init(style: .plain)
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: NSNotification.Name(rawValue: SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    // MARK: - UI
    @objc func seasonDidChange(notification: Notification) {
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        let season = info[SEASON_KEY] as? Season
        
        // Actualizar el modelo de este controlador
        model = season!.sortedMembers
        
        // Sincronizar la vista
        syncModelWithView()
    }
    
    
    
    // MARK: - Sync
    func syncModelWithView() {
        // Recargar los datos de la UITableView
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "EpisodeCell"
        
        // Descubrir cuál es la temporada que tenemos que mostrar
        let episode = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) // Comprobar si hay alguna cacheada que se pueda reutilizar
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Texto de la celda
        cell?.textLabel?.text = episode.title
        
        // Texto detallado (fecha de emisión)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "MMMM d, y"
        let date = dateFormatter.string(from: episode.airDate)
        cell?.detailTextLabel?.text = "First Aired: \(date)"
        
        return cell!
    }
    
    
    // Mark: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = model[indexPath.row]
        
        // Creo la vista detallada
        let episodeDetailView = EpisodeDetailViewController(model: episode)
        
        // Hago un push de la vista detallada
        navigationController?.pushViewController(episodeDetailView, animated: true)
    }
    
}
