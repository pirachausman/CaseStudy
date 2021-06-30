//
//  PhotoCollectionViewCell.swift
//  CaseStudy
//
//  Created by Usman Piracha on 29/06/2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImage: CacheImageView! = {
        let imageView = CacheImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                //transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                layer.borderWidth = 2
                layer.borderColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
            } else {
              //  transform = CGAffineTransform.identity
                layer.borderWidth = 0
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
}
