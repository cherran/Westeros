//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 16/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

class MemberListViewController: UITableViewController {
        
    // MARK: - Properties
    var model: [Person]
    
    
    // MARK: - Initialization
    init(model: [Person]){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default // Singleton
        
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: NSNotification.Name(rawValue: HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    // MARK: - UI
    @objc func houseDidChange(notification: Notification) {
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        let house = info[HOUSE_KEY] as? House // CASTING, se puede hacer opcional (as?) o por cojones (as!)
        
        // Actualizar el modelo de este controlador
        model = house!.sortedMembers
        
        // Sincronizar la vista
        syncModelWithView()
    }
    
    
    // MARK: - Sync
    func syncModelWithView() {
        // Recargar los datos de la UITableView
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "MemberCell"
        
        // Descubrir la persona que tenemos que mostrar
        let person = model[indexPath.row]
        
        // Preguntar por una celda (a una caché) o Crearla
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Interesante hacerlo así también:
        //        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        //            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        // Sincronizar celda y persona
        cell?.textLabel?.text = person.fullName
        
        // Devolver la celda
        return cell!
    }

    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = model[indexPath.row]
        
        // Creo la vista detallada
        let memberDetailView = MemberDetailViewController(model: member)
        
        // Hago un push de la vista detallada
        navigationController?.pushViewController(memberDetailView, animated: true)
    }
    
}
