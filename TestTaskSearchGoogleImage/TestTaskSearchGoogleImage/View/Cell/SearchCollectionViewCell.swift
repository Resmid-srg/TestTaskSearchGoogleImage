//
//  SearchCollectionViewCell.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 06.02.23.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!

    func setup(imageThumbnailUrl: String) {
        self.cellImageView.sd_setImage(with: URL(string: imageThumbnailUrl))
    }
}
