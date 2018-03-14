//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 8/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    let model: [Person]
    
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asignamos delegado
        tableView.delegate = self
        
        // Asignamos la fuente de datos
        tableView.dataSource = self
    }

}


// MARK: - UITableViewDataSource
extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
}


// MARK: - UITableViewDelegate
extension MemberListViewController: UITableViewDelegate {
    
}



