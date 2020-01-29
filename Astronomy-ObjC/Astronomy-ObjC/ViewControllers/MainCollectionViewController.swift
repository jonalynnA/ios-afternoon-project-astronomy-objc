//
//  MainCollectionViewController.swift
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {

    private let client = CCCMarsRoverClient()
        private var roverInfo: CCCMarsRover? {
            didSet {
                solDescription = roverInfo?.solDescriptions[100]
            }
        }
        private var solOffset = 0
        private var solDescription: CCCSolDescription? {
            didSet {
                if let rover = roverInfo,
                    let sol = solDescription?.sol {
                    DispatchQueue.main.async {
                        self.title = self.solDescription?.sol.stringValue
                    }
                    client.fetchPhotos(from: rover, onSol: sol) { (photoRefs, error) in
                        if let e = error { NSLog("Error fetching photos for \(rover.name) on sol \(sol): \(e)"); return }
                        self.photoReferences = photoRefs ?? []
                    }
                }
            }
        }
        private var photoReferences = [CCCMarsPhotoReference]() {
            didSet {
                DispatchQueue.main.async { self.collectionView?.reloadData() }
            }
        }
        
        let cache = CCCCache()
        
        private let photoFetchQueue = OperationQueue()
        private var fetchDictionary: [Int: Operation] = [:]

        override func viewDidLoad() {
            super.viewDidLoad()
            client.fetchMarsRover(withName: "curiosity") { (rover, error) in
                if let error = error {
                    NSLog("Error fetching info for curiosity: \(error)")
                    return
                }
                
                self.roverInfo = rover
            }
        }

        
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "PhotoDetailShowSegue" {
                guard let detailVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPathsForSelectedItems?.first, let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
                let photoReference = photoReferences[indexPath.row]
                detailVC.photoReference = photoReference
                detailVC.photo = cell.imageView.image
            }
        }
        

        // MARK: UICollectionViewDataSource


        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of items
            return photoReferences.count
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else { fatalError("cannot make imageCell") }
            
            loadImage(forCell: cell, forItemAt: indexPath)
    //        let photoReference = photoReferences[indexPath.row]
    //
    //        if let cacheData = cache.value(forKey: photoReference.refernceId.stringValue) {
    //            cell.imageView.image = UIImage(data: cacheData)
    //            return cell
    //        }
    //
    //        let url = photoReference.imageURL
    //
    //        client.fetchImage(fromPhotoURL: url) { (data, error) in
    //            if let error = error {
    //                print("error fetching image: \(error)")
    //            }
    //            guard let data = data else { return }
    //            self.cache.cacheValue(forKey: photoReference.refernceId.stringValue, value: data)
    //            DispatchQueue.main.async {
    //                cell.imageView.image = UIImage(data: data)
    //            }
    //
    //        }
            
            
            return cell
        }
        
        private func loadImage(forCell cell: ImageCollectionViewCell, forItemAt indexPath: IndexPath) {
                
                let photoReference = photoReferences[indexPath.item]
                
            let photoFetchOperation = CCCFetchPhotoOperation(photoReference: photoReference)!
                let saveCacheOperation = BlockOperation {
                    self.cache.cacheValue(forKey: photoReference.refernceId.stringValue, value: photoFetchOperation.imageData)
                }
                let setUpImageViewOperation = BlockOperation {
                    DispatchQueue.main.async {
                        
                        cell.imageView.image = UIImage(data: photoFetchOperation.imageData!)
                        
                    }
                }
            if let imageData = cache.value(forKey: photoReference.refernceId.stringValue) {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                        print("loaded cache image")
                        return
                    }
                }

                saveCacheOperation.addDependency(photoFetchOperation)
                setUpImageViewOperation.addDependency(photoFetchOperation)
            
                photoFetchQueue.addOperations([photoFetchOperation, saveCacheOperation, setUpImageViewOperation], waitUntilFinished: true)
                
            fetchDictionary[photoReference.refernceId.intValue] = photoFetchOperation
            }
        
        @IBAction func next(_ sender: Any) {
            solOffset += 1
            solDescription = roverInfo?.solDescriptions[100 + solOffset]
        }
        @IBAction func previous(_ sender: Any) {
            solOffset -= 1
            solDescription = roverInfo?.solDescriptions[100 + solOffset]
        }
        

    }
