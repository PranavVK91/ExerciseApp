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
        label.numberOfLines = 20
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
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(countryDetailsImageView)
        titleLabel.bringSubviewToFront(countryDetailsImageView)
        descriptionLabel.bringSubviewToFront(countryDetailsImageView)
        configureTitleLabel()
        configureCountryDetailsImageView()
        configureDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     Method to update the contents of reusable cell, and expecting model as parameter.
     */
    func bind(_ viewModel: CountryDetailsModel?) {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title ?? ""
        descriptionLabel.text = viewModel.description ?? ""
        print(viewModel.description ?? "")
        countryDetailsImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        countryDetailsImageView.sd_setImage(with: viewModel.getImageUrl(), placeholderImage: UIImage(named: "placeHolder"))
    }
    
    // MARK:- Methods to update cell constraints
    
    func configureTitleLabel() {
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 5)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .left)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .right)
        titleLabel.autoSetDimension(.height, toSize: 25)
    }
    
    func configureCountryDetailsImageView() {
        countryDetailsImageView.autoPinEdge(.top, to:.bottom, of: titleLabel, withOffset: 5)
        countryDetailsImageView.autoPinEdge(toSuperviewSafeArea: .left, withInset: 10)
        countryDetailsImageView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20, relation: .greaterThanOrEqual)
        countryDetailsImageView.autoSetDimension(.width, toSize: 200, relation: .equal)
        countryDetailsImageView.autoSetDimension(.height, toSize: 200, relation: .equal)
        countryDetailsImageView.contentMode = .scaleAspectFit
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 5)
        descriptionLabel.autoPinEdge(.left, to: .right, of: countryDetailsImageView, withOffset: 5)
        descriptionLabel.autoPinEdge(toSuperviewSafeArea: .right, withInset: 10)
        descriptionLabel.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20, relation: .equal)
        descriptionLabel.textAlignment = .left
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}

