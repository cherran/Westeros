//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 2/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    // @IBOutlet --> lo vamos a referenciar en la interfaz gráfica (va a ser linkado a una vista del .xib
    
    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // Mark: - Properties
    let model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        // Es lo mismo que hacer esto (a que tienen el mismo nombre):
        // super.init(nibName: "houseDetailViewController", bundle: Bundle(for: HouseDetailViewController.self))
        
        title = model.name
    }
    
    
    // Chapuza de los de Cupertino relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
    }
    
    
    // MARK: - Sync
    func syncModelWithView() {
        // Model --> View
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    

}
