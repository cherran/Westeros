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
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        // Es lo mismo que hacer esto (ya que tienen el mismo nombre):
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
        setupUI()
        syncModelWithView()
    }
    
    
    // MARK: - Sync
    func syncModelWithView() {
        // Model --> View
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    
    // Mark: - UI
    // crear una vista por código
    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        // #selector: Selector? () --> identificador del método
        // target: clase en la que está el método
        let members = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        navigationItem.rightBarButtonItems = [wikiButton, members]
    }
    
    @objc func displayWiki() {
        // Creamos el WikiVC
        let wikiViewController = WikiViewController(model: model)
        
        // Hacemos el push
        navigationController?.pushViewController(wikiViewController, animated: true)
        
    }
    
    @objc func displayMembers() {
        // Creamos el VC
        let memberListViewController = MemberListViewController(model: model.sortedMembers)
        
        // Hacemos Push
        navigationController?.pushViewController(memberListViewController, animated: true)
    }

}

extension HouseDetailViewController: HouseListTableViewControllerDelegate {
    func houseListViewController(_ viewController: HouseListTableViewController, didSelectHouse house: House) {
        self.model = house
        // self.title = house.name
        syncModelWithView()
    }
    
    
}








