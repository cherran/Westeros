//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 16/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
 
    
    // MARK: - Properties
    let model: Person
    
    
    // MARK: - Initialization
    init (model: Person) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
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
        // La casa ha cambiado, volver a la vista anterior (lista de personajes) que ya se habrá atualizado a la nueva casa seleccionada
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - SYNC
    func syncModelWithView() {
        ImageView.image = model.house.sigil.image
        NameLabel.text = "\(model.fullName)"
        
    }


}
