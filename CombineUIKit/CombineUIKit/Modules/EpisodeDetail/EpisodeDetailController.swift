//
//  EpisodeDetailController.swift
//  CombineUIKit
//
//  Created by Carlos Diaz on 17/08/21.
//

import UIKit

class EpisodeDetailController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    func setUpView() {
        guard let episode = episode else { return }
        decriptionLabel.text = episode.episode
        otherLabel.text = episode.name
    }
}
