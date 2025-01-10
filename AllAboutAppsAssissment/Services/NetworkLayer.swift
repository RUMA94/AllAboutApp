//
//  NetworkLayer.swift
//  AllAboutAppsAssissment
//
//  Created by Moaaz Ahmed Fawzy Taha on 24/01/2022.
//

import Foundation

class NetworkLayer {
    static let shared = NetworkLayer()
    
    private init() {}
    
    // creat URL
     var baseURL:String {
        get {
            guard let filePath = Bundle.main.path(forResource: CommonKeys.info.rawValue, ofType: CommonKeys.plist.rawValue) else {
                fatalError("Couldn't find file 'info.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: CommonKeys.baseURL.rawValue) as? String else {
                fatalError("Couldn't find key '\(CommonKeys.baseURL.rawValue)' in '\(CommonKeys.info.rawValue)'.")
            }
            return value
        }
    }
    
    // MARK: - Fetch Data from API
    
    func fetchClubs(handler: @escaping ([Club])->Void) {
        
        let url = URL(string: baseURL + "/hiring/clubs.json")!
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { [weak self] Data, URLResponse, Error in
            guard let self = self else {return}
            
            if let Error = Error {
                print (Error.localizedDescription)
            }
            if let data = Data {
                let clubs = self.decodeJson(Data: data)
                handler(clubs)
                }
            }
        task.resume()
        }
    
    //MARK: -decoding jason data from apii
    
    private func decodeJson(Data:Data)-> [Club] {
        
        let decoder = JSONDecoder()
        
        do {
            let dataDecoded = try decoder.decode([Club].self, from: Data)
            return dataDecoded
            
        } catch let error {
            print(String(describing: error.localizedDescription))
            return []
        }
    }
}


