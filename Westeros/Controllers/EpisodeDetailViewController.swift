//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 15/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DetailLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    
    // MARK: - Properties
    let model: Episode
    
    
    
    // MARK: - Initialization
    init(model: Episode) {
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
        // Hacer pop y volver a la lista de capítulos, que ya habrá cambiado
        navigationController?.popViewController(animated: true)
    }
    

    
    
    
    // MARK: - Sync
    func syncModelWithView() {
        title = model.title
        
        TitleLabel.text = model.title
        
        let episodeNumber = model.season?.sortedMembers.index(of: model)
        DetailLabel.text = "\(model.season?.name ?? "Unkown Season"), Episode \(episodeNumber!)"
        
        // fecha de emisión
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "MMMM d, y"
        let date = dateFormatter.string(from: model.airDate)
        DateLabel.text = "First Aired on \(date)"
        
    }
    
}
