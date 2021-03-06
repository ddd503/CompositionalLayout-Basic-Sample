//
//  PhotoListCell.swift
//  CompositionalLayout-Basic-Sample
//
//  Created by kawaharadai on 2020/01/25.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit
import Photos

final class PhotoListCell: UICollectionViewCell {

    @IBOutlet weak private var imageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    func setImage(asset: PHAsset) {
        let imageLength = imageView.bounds.width * 4
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: imageLength, height: imageLength),
                                              contentMode: .aspectFill,
                                              options: nil) { (image, _) in
                                                DispatchQueue.main.async { [weak self] in
                                                    self?.imageView.image = image
                                                }
        }
    }

}
