//
//  ClubListVM.swift
//  AllAboutAppsAssissment
//
//  Created by Moaaz Ahmed Fawzy Taha on 24/01/2022.
//

import Foundation
import Reachability

enum SoritngParameter:Int {
    case defaultSorting
    case NameAsending
    case ClubValueDesendingly
}

class ClubsListViewModel {
    
    var clubs:[Club] = []
    var defaultClubs:[Club] = []
    var selectedSortingParameter:SoritngParameter = .defaultSorting

    
    func fetchClubs(completion: @escaping ()->Void) {
        NetworkLayer.shared.fetchClubs { clubs in
                self.clubs = clubs
                self.defaultClubs = clubs
                self.sorting(with: self.selectedSortingParameter)
                completion()
        }
    }
    
    func sorting(with parameter: SoritngParameter) {
        // to be considered while fetching.
        selectedSortingParameter = parameter
        
        if parameter == .defaultSorting {
            clubs = defaultClubs
            return
        }
        clubs = clubs.sorted { club1, club2 in
            switch parameter {
            case .NameAsending:
                return club1.name! < club2.name!
            case .ClubValueDesendingly:
                return club1.value! > club2.value!
            default:
                return true
            }
        }
    }
    
}
