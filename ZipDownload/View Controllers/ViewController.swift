//
//  ViewController.swift
//  ZipDownload
//
//  Created by Duncan MacDonald on 11/3/17.
//  Copyright © 2017 Duncan MacDonald. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var infoObjects: [JsonModel] = [] {
        didSet {
            reloadCollection()
        }
    }
    
    func reloadCollection() {
        DispatchQueue.main.async {
            print("reloaded")
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView.indexPathsForSelectedItems?[0] {
            let destVc = segue.destination as! ImagesViewController
            destVc.images = infoObjects[indexPath.row].images
            //print(destVc.images.count)
        }
    }

    override func viewDidLoad() {
        NetworkService.networkRequest { (objects) in
            self.infoObjects = objects
            
            for i in self.infoObjects {
                NetworkService.downloadFile(url: i.zipUrl, completion: { (url) in
                    UnzipService.unzip(url: url, name: i.collectionName, completion: { (fileUrl) in
                        do {
                            i.imagePaths = try FileManager.default.contentsOfDirectory(at: fileUrl.appendingPathComponent(i.fileName), includingPropertiesForKeys: nil, options: []).filter{ $0.pathExtension == "jpeg" || $0.pathExtension == "jpg" }
                            
                            i.collectionImagePath = try FileManager.default.contentsOfDirectory(at: fileUrl.appendingPathComponent(i.fileName), includingPropertiesForKeys: nil, options: []).filter{ $0.pathExtension == "png" }[0]
                            
                            do {
                                let collectionData = try Data(contentsOf: i.collectionImagePath)
                                i.collectionImage = UIImage(data: collectionData)
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            for img in i.imagePaths {
                                do {
                                    print("created image for \(i.collectionName)")
                                    self.reloadCollection()
                                    let data = try Data(contentsOf: img)
                                    let image = UIImage(data: data)
                                    i.images.append(image!)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    })
                })
            }
        }
    }


}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.infoObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("created cell")
        let cell: CollectionImgCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionImgCell", for: indexPath) as! CollectionImgCell
        let folder = self.infoObjects[indexPath.row]
        cell.imageView.image = folder.collectionImage
        return cell
    }
}



