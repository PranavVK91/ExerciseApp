//
//  CountryTableViewCell.swift
//  ExerciseApp
//
//  Created by Pranav V K on 10/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import UIKit
import PureLayout
import SDWebImage

class CountryTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 0.5
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowOffset = CGSize(width: 0.0, height: -0.5)
        label.layer.zPosition = 1
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 10
        label.font = UIFont(name:"HelveticaNeue", size: 16.0)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 0.5
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowOffset = CGSize(width: 0.0, height: -0.5)
        label.layer.zPosition = 1
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var countryDetailsImageView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(countryDetailsImageView)
        titleLabel.bringSubviewToFront(countryDetailsImageView)
        descriptionLabel.bringSubviewToFront(countryDetailsImageView)
        updateTitleLabelConstraints()
        updateDescriptionLabelConstraints()
        countryDetailsImageView.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: CountryDetailsModel?) {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title ?? ""
        descriptionLabel.text = viewModel.description ?? ""
        countryDetailsImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        countryDetailsImageView.sd_setImage(with: viewModel.getImageUrl(), placeholderImage: UIImage(named: "placeHolder"))
    }
    
    func updateTitleLabelConstraints() {
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .right)
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        titleLabel.autoSetDimensions(to: CGSize(width: self.contentView.frame.width, height: 50))
    }
    
    func updateDescriptionLabelConstraints() {
        descriptionLabel.autoPinEdge(toSuperviewEdge: .right)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .left)
        descriptionLabel.autoSetDimensions(to: CGSize(width: self.contentView.frame.width, height: 150))
        descriptionLabel.autoCenterInSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
        bounds = bounds.inset(by: padding)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}

