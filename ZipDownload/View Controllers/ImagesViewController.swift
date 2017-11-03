//
//  ImagesViewController.swift
//  ZipDownload
//
//  Created by Duncan MacDonald on 11/3/17.
//  Copyright © 2017 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

class ImagesViewController: UIViewController {
    var images: [UIImage]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension ImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionImgCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionImgCell2", for: indexPath) as! CollectionImgCell
        if let images = images {
            let currentImg: UIImage = images[indexPath.row]
            cell.imageView.image = currentImg
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
}
