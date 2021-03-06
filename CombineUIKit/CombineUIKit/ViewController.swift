//
//  ViewController.swift
//  CombineUIKit
//
//  Created by Carlos Diaz on 23/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkManager.sharedInstance.getEpisode(url: "https://rickandmortyapi.com/api/episode/28") { }
    }

    // Esta función es solo para hacer pruebas dusrante el desarrollo
    @IBAction func showEpisodesAction(_ sender: Any) {
        let navigation = UINavigationController(rootViewController: EpisodesController())
        navigation.modalPresentationStyle = .overFullScreen
        self.present(navigation, animated: true, completion: nil)
    }
    
    // Esta función es solo para hacer pruebas dusrante el desarrollo
    @IBAction func showCharactersAction(_ sender: Any) {
        
    }
    
    @IBAction func testServiceAction(_ sender: Any) {
        NetworkManager.sharedInstance.getEpisode(url: "https://rickandmortyapi.com/api/episode/28") { }
    }
    
    
}

