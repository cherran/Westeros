//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 15/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

// MARK: - SeasonListViewControllerDelegate
protocol EpisodeListViewControllerDelegate: class {
    func episodeListViewController(_ viewController: EpisodeListViewController, didSelectEpisode: Episode)
}


class EpisodeListViewController: UITableViewController {
    // Mark: - Properties
    let model: [Episode]
    weak var delegate: EpisodeListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [Episode]) {
        self.model = model
        super.init(style: .plain)
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    
    
    // MARK: - UI
    func setupUI() {
        let episodesButton = UIBarButtonItem(title: "<Episodes", style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = episodesButton
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
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
        dateFormatter.dateFormat = "MMMM d, y"
        let date = dateFormatter.string(from: episode.airDate)
        cell?.detailTextLabel?.text = "First Aired: \(date)"
        
        return cell!
    }
    
    
    // Mark: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = model[indexPath.row]
        
        // Creo la vista detallada
        // let episodeDetailView = EpisodeDetailViewController(model: season)
        
        // Hago un push de la vista detallada
        // navigationController?.pushViewController(episodeDetailView, animated: true)
        
        // Aviso al delegado
        // delegate?.episodeListViewController(self, didSelectEpisode: episode)
    }
    
}
