//
//  PhotoTitleTableViewCell.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 1/2/19.
//  Copyright © 2019 Mathieu Lamvohee. All rights reserved.
//

import UIKit

class PhotoTitleTableViewCell: UITableViewCell {
    
    //MARK: - Cell Reuse Identifier
    static let reuseIdentifier = "photoTitleCell"
    
    //MARK: - Outlets
    let containerView: UIView = {
        let container = UIView.newAutoLayout()
        return container
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel.newAutoLayout()
        return titleLabel
    }()
    
    //MARK: - Properties
    var photoThumbnailViewModel: PhotoThumbnailViewModel! {
        didSet{
            
            if let title = photoThumbnailViewModel.title {
                titleLabel.text = title
                titleLabel.textAlignment = NSTextAlignment.center
            }
        }
    }
    var didSetupConstraints = false
    
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

    
    //MARK: - Methods
    func setupViews() {
        self.addSubview(containerView)
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
            
            //Title Label Constraints
            titleLabel.autoPinEdgesToSuperviewEdges()
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }

}
