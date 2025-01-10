//
//  ClubListCell.swift
//  AllAboutAppsAssissment
//
//  Created by Moaaz Ahmed Fawzy Taha on 24/01/2022.
//

import UIKit

class ClubListCell: UITableViewCell {
    @IBOutlet weak var clubLogo: UIImageView!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var clubNationality: UILabel!
    @IBOutlet weak var clubValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Configuring the cell
    func configuringCell(club:Club) {
        clubLogo.sd_setImage(with: URL(string:(club.image!)))
        clubName.text = club.name
        clubNationality.text = club.country
        clubValue.text = String(describing: club.value!) + "Million".localized()
    }
    
    
}
