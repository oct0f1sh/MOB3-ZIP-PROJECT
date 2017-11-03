//
//  NetworkService.swift
//  ZipDownload
//
//  Created by Duncan MacDonald on 11/3/17.
//  Copyright © 2017 Duncan MacDonald. All rights reserved.
//

import Foundation

class NetworkService {
    static let url = "https://api.myjson.com/bins/17ge17"
    
    static func networkRequest(completion: @escaping ([JsonModel]) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let objects = try! decoder.decode([JsonModel].self, from: data)
                completion(objects)
            }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    static func downloadFile(url: String, completion: @escaping (URL) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                completion(tempLocalUrl)
            }
        }
        task.resume()
    }
}
