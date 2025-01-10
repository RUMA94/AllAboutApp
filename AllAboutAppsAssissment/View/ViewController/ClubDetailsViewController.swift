//
//  ClubDetailsViewController.swift
//  AllAboutAppsAssissment
//
//  Created by Moaaz Ahmed Fawzy Taha on 24/01/2022.
//

import UIKit

class ClubDetailsViewcontroller: BaseViewController {
    @IBOutlet weak var clubLogo: UIImageView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var Details: UILabel!
    
    var viewModel:ClubDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
        self.title = viewModel?.club?.name
    }
    
    private func loadDetails() {
        guard let club = viewModel?.club else {return}
        
        if let imageStr = club.image, let imageURL = URL(string:imageStr) {
            clubLogo.sd_setImage(with: imageURL)
        }
        country.text = club.country
        

        let fontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
        let AttrCountry = NSAttributedString(string: club.name ?? "", attributes: fontAttribute)

        let description = NSMutableAttributedString(string: "The club".localized())
        description.append(AttrCountry)
        description.append(NSAttributedString(string: "ClubDetails.description".localized().replacingOccurrences(of: "[country]", with: club.country ?? "").replacingOccurrences(of: "[value]", with: "\(club.value ?? 0)")))
       
        // set attributed text on a UILabel
        Details.attributedText = description
    }
}

