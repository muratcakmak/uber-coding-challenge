//
//  EpisodeListTableViewCell.swift
//  UberCodingChallenge
//
//  Created by muratcakmak on 19.12.2017.
//  Copyright © 2017 Murat Cakmak. All rights reserved.
//

import UIKit

class EpisodeListTableViewCell: UITableViewCell {

  @IBOutlet weak var thumbnail: UIImageView!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var airdate: UILabel!
  @IBOutlet weak var episode: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
