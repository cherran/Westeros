//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 15/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var SeasonLabel: UILabel!
    @IBOutlet weak var FirstAiredLabel: UILabel!
    @IBOutlet weak var EpisodesLabel: UILabel!
    @IBOutlet weak var EpisodesButton: UIButton!
    
    
    // MARK: - Properties
    var model: Season
    
    
    // MARK: - Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        syncModelWithView()
    }
    
    
    // MARK: - UI
    func setupUI() {
        let seasons = UIBarButtonItem(title: "<Seasons", style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = seasons
        
        EpisodesButton.setTitle("Detail", for: .normal)
        EpisodesButton.addTarget(self, action: #selector(displayEpisodes), for: .touchDown)
        
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func displayEpisodes() {
        // Creo el EpisodeList VC
        let episodeListViewController = EpisodeListViewController(model: model.sortedMembers)
        
        // Lo pusheo
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        // Sincronizar el modelo con la vista
        title = model.name
        
        SeasonLabel.text = model.name
        
        // fecha de emisión
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, y"
        let date = dateFormatter.string(from: model.airDate)
        FirstAiredLabel.text = "First Aired on \(date)"
        
        // Número de capítulos
        EpisodesLabel.text = "Number of episodes: \(model.count)"
    }

}



extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
    
    
}





