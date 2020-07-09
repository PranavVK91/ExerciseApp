//
//  CountryTableViewCell.swift
//  ExerciseApp
//
//  Created by Pranav V K on 10/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import UIKit
import PureLayout

class CountryTableViewCell: UITableViewCell {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 25)
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 10
        label.font = UIFont(name: "Arial", size: 20)
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
        countryDetailsImageView.image = UIImage(named: "placeHolder")
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
        descriptionLabel.autoSetDimensions(to: CGSize(width: self.contentView.frame.width, height: 100))
        descriptionLabel.autoCenterInSuperview()
    }
}

