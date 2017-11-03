//
//  File.swift
//  ZipDownload
//
//  Created by Duncan MacDonald on 11/3/17.
//  Copyright © 2017 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

class JsonModel: Decodable {
    var collectionName: String!
    var zipUrl: String!
    var fileName: String!
    var imagePaths: [URL] = []
    var collectionImagePath: URL!
    var images: [UIImage] = []
    var collectionImage: UIImage? = nil
    
    enum Keys: String, CodingKey {
        case collectionName = "collection_name"
        case zipUrl = "zipped_images_url"
    }
    
    init(collectionName: String, imageUrl: String) {
        self.collectionName = collectionName
        self.zipUrl = imageUrl
        
        switch self.collectionName {
        case "Lions":
            self.fileName = "lion"
        case "Swimming":
            self.fileName = "swimming"
        case "Forests":
            self.fileName = "forest"
        default:
            self.fileName = "lion"
        }
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let collectionName = try container.decode(String.self, forKey: .collectionName)
        let imageUrl = try container.decode(String.self, forKey: .zipUrl)
        
        self.init(collectionName: collectionName, imageUrl: imageUrl)
    }
}
