//
//  PhotosCollectionViewCell.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 1/2/19.
//  Copyright © 2019 Mathieu Lamvohee. All rights reserved.
//

import UIKit
import PureLayout
import SDWebImage

class PhotosCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Cell Reuse Identifier
    static let reuseIdentifier = "photosCell"
    
    //MARK: - Outlets
    let containerView: UIView = {
        let container = UIView.newAutoLayout()
        container.layer.cornerRadius = 5
        container.backgroundColor = UIColor.white
        return container
    }()
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    //MARK: - Properties
    var didSetupConstraints = false
    var photoThumbnailViewModel: PhotoThumbnailViewModel! {
        didSet{
            if let url = photoThumbnailViewModel.imageURL {
                thumbnailImageView.sd_setImage(with: URL(string: url), completed: nil)
            }
            if let title = photoThumbnailViewModel.title {
                titleLabel.text = title
            }
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setupViews() {
        self.addSubview(containerView)
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(titleLabel)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            
            //ContainerView Constraints
            containerView.autoPinEdge(toSuperviewEdge: .top)
            containerView.autoPinEdge(toSuperviewEdge: .leading)
            containerView.autoPinEdge(toSuperviewEdge: .trailing)
            containerView.autoPinEdge(toSuperviewEdge: .bottom)
            
            //Thumbnail ImageView Constraints
            thumbnailImageView.autoPinEdge(toSuperviewEdge: .top)
            thumbnailImageView.autoPinEdge(toSuperviewEdge: .leading)
            thumbnailImageView.autoPinEdge(toSuperviewEdge: .trailing)
            thumbnailImageView.autoMatch(.height, to: .width, of: thumbnailImageView)
            
            //Title Label Constraints
            titleLabel.autoPinEdge(.top, to: .bottom, of: thumbnailImageView)
            titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10.0)
            titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10.0)
            titleLabel.autoPinEdge(toSuperviewEdge: .bottom)
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
}
