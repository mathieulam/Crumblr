//
//  ImageViewTableViewCell.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 1/3/19.
//  Copyright © 2019 Mathieu Lamvohee. All rights reserved.
//

import UIKit
import PureLayout
import SDWebImage

class ImageViewTableViewCell: UITableViewCell {

    //MARK: - Cell reuseIdentifier
    static let reuseIdentifier = "headerImageCell"
    
    //MARK: - Outlets
    let containerView: UIView = {
        let container = UIView.newAutoLayout()
        return container
    }()
    
    let photoLargeImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Properties
    var didSetupConstraints = false
    var containerViewBottomConstraint: NSLayoutConstraint!
    var containerViewTopConstraint: NSLayoutConstraint!
    var photoThumbnailViewModel: PhotoThumbnailViewModel! {
        didSet{
            if let imageUrl = photoThumbnailViewModel.imageURL {
                photoLargeImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
            }
        }
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Methods
    func setupViews() {
        self.addSubview(containerView)
        containerView.addSubview(photoLargeImageView)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            
            //ContainerView Constraints
            containerView.autoPinEdge(toSuperviewEdge: .top)
            containerView.autoSetDimension(.width, toSize: UIScreen.main.bounds.size.width)
            containerView.autoPinEdge(toSuperviewEdge: .bottom)
            
            //Image Constraints
            photoLargeImageView.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 0 {
            // scrolling up
            containerView.clipsToBounds = true
            containerViewBottomConstraint?.autoRemove()
            containerViewTopConstraint?.autoRemove()
            
            //Init Constraints
            containerViewTopConstraint = containerView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            containerViewBottomConstraint = containerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
            
            //Update Constraints
            containerViewBottomConstraint.constant = -scrollView.contentOffset.y / 2
            containerViewTopConstraint.constant = scrollView.contentOffset.y / 2
            
        } else {
            // scrolling down
            containerViewTopConstraint?.autoRemove()
            //Init Constraints
            containerViewTopConstraint = containerView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            //Update Constraints
            containerViewTopConstraint.constant = scrollView.contentOffset.y
            containerView.clipsToBounds = false
        }
    }
}
