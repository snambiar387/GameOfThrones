//
//  KingTableViewCell.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
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

    func configure(viewModel: KingListViewModel) {
        
        kingNameLabel.text = viewModel.name
        ratingLabel.text = viewModel.eloRating
        numberOfWinsLabel.text = viewModel.totalWin
        numberOfAttacksLabel.text = viewModel.attacksMade
        numberOfDefendsLabel.text = viewModel.defendsMade
    }
    }
