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
    }

    // Esta función es solo para hacer pruebas dusrante el desarrollo
    @IBAction func showEpisodesAction(_ sender: Any) {
        let episodesController = EpisodesController()
        self.present(episodesController, animated: true, completion: nil)
    }
    
    // Esta función es solo para hacer pruebas dusrante el desarrollo
    @IBAction func showCharactersAction(_ sender: Any) {
        
    }
    
}

