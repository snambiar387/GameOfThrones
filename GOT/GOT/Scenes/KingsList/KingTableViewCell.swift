//
//  KingTableViewCell.swift
//  GOT
//
//  Created by macadmin on 5/12/18.
//  Copyright © 2018 macadmin. All rights reserved.
//

import UIKit

class KingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kingdomImageView: UIImageView!
    @IBOutlet weak var kingNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var numberOfWinsLabel: UILabel!
    @IBOutlet weak var numberOfAttacksLabel: UILabel!
    @IBOutlet weak var numberOfDefendsLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: KingViewModel) {
        
        kingNameLabel.text = viewModel.name
        ratingLabel.text = viewModel.eloRating
        numberOfWinsLabel.text = viewModel.totalWin
        numberOfAttacksLabel.text = viewModel.attacksMade
        numberOfDefendsLabel.text = viewModel.defendsMade
    }

}
