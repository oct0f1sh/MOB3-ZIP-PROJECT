//
//  UnzipService.swift
//  ZipDownload
//
//  Created by Duncan MacDonald on 11/3/17.
//  Copyright © 2017 Duncan MacDonald. All rights reserved.
//

import Foundation
import Zip

class UnzipService {
    
    static func unzip(url: URL, name: String, completion: @escaping (URL) -> Void) {
        Zip.addCustomFileExtension("tmp")
        do {
            let unzipDirectory = try Zip.quickUnzipFile(url)
            completion(unzipDirectory)
        }
        catch {
            print("Something went wrong")
        }

    }
}
