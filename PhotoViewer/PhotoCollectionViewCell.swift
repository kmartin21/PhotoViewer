//
//  PhotoCollectionViewCell.swift
//  PhotoViewer
//
//  Created by keith martin on 8/23/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    let thumbnailImageView: UIImageView
    
    override init(frame: CGRect) {
        thumbnailImageView = UIImageView(frame: .zero)
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .backgroundLightGrey
    
        setupImageView()
    }
    
    private func setupImageView() {
        thumbnailImageView.backgroundColor = .clear
        thumbnailImageView.layer.cornerRadius = 3
        thumbnailImageView.clipsToBounds = true
        addSubview(thumbnailImageView)
        
        createImageViewConstraints()
    }
    
    private func createImageViewConstraints() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
    }
}
