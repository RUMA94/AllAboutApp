//
//  Reachability.swift
//  AllAboutAppsAssissment
//
//  Created by Moaaz Ahmed Fawzy Taha on 24/01/2022.
//

import Foundation
import Reachability

class ReachabilitySingelton  {
    let reachability = try! Reachability()
    static let shared = ReachabilitySingelton()
    
    private init() {
        do{
          try reachability.startNotifier()
        }catch{
          print("could not start reachability notifier")
        }
    }
}
