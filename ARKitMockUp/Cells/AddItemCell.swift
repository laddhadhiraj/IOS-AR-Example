//
//  AddItemCell.swift
//  ARKitMockUp
//
//  Created by Dhiraj Laddha on 22/04/19.
//  Copyright © 2019 Dhiraj Laddha. All rights reserved.
//

import UIKit

class AddItemCell: UICollectionViewCell {

    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(imgName: String) {
        imgView.image = UIImage.init(named: imgName)
    }

}
