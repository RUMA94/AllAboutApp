//
//  Club.swift
//  AllAboutAppsAssissment
//
//  Created by Moaaz Ahmed Fawzy Taha on 25/01/2022.
//

import Foundation
struct Club : Decodable {
    let id : String?
    let name : String?
    let country : String?
    let value : Int?
    let image : String?
    let european_titles : Int?
    let stadium : Stadium?
    let location : Location?
}

struct Location : Decodable {
    let lat : Double?
    let lng : Double?
}

struct Stadium : Decodable {
    let size : Int?
    let name : String?
}
