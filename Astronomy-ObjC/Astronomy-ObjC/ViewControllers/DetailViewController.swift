//
//  DetailViewController.swift
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var solLabel: UILabel!
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var cameraLabel: UILabel!
        @IBOutlet weak var earthDateLabel: UILabel!
        
        var photoReference: CCCMarsPhotoReference?
        var photo: UIImage?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            updateViews()

            // Do any additional setup after loading the view.
        }
        private func updateViews() {
            guard let photoReference = photoReference, isViewLoaded, let photo = photo else { return }
            solLabel.text = "Sol: " + photoReference.sol.stringValue
            imageView.image = photo
            cameraLabel.text = "Camera: " + photoReference.camera.fullName
            print(photoReference.camera.name)
            earthDateLabel.text = "Earth date: " + photoReference.earthDate
        }
    }
