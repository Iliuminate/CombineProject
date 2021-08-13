//
//  EpisodeCell.swift
//  CombineUIKit
//
//  Created by Carlos Diaz on 23/07/21.
//

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with item: Episode) {
        idLabel.text = String(item.id)
        nameLabel.text = item.name
        episodeLabel.text = item.episode
        dateLabel.text = item.date
    }
}

// MARK: - Cell Identifiers -
extension EpisodeCell {
    
    public static let cellName = "EpisodeCell"
}
