//
//  WikiViewController.swift
//  Westeros
//
//  Created by Carlos de la Herrán Martín on 6/3/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    // Mark: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // Mark: - Properties
    var model: House
    
    
    // Mark: - Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    // chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        webView.navigationDelegate = self // para el activityIndicatorView
        
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default // Singleton
        
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: NSNotification.Name(rawValue: HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        // object: nil --> no nos interesa qué objeto lo manda. Si fuese necesario, valorar si no es mejor implementarlo con un Delegate (más directo)
        // selector: #selector(houseDidChange) --> el selector del método que se debe llamar al llegar la notificación
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
        
        // el deinit (closure) también es buen sitio para darnos de baja
        // En este caso es mejor hacerlo aquí, ya que probablemente vaya a mostrar otro WikiViewController antes de que este se elimine de la memoria
        // Un VC sólo dessaparece de memoria en este caso cuando le hacemos POP
    }
    
    
    // Mark: - Sync
    func syncModelWithView() {
        title = model.name
        webView.load(URLRequest(url: model.wikiURL))
    }
    
    
    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) { // Estos métodos siempre deben recibir el objeto notification
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        let house = info[HOUSE_KEY] as? House // CASTING, se puede hacer opcional (as?) o por cojones (as!)
        
        // Actualizar el modelo de este controlador
        model = house!
        
        // Sincronizar la vista
        syncModelWithView()
    }
    
}



extension WikiViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let type = navigationAction.navigationType
        
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}


