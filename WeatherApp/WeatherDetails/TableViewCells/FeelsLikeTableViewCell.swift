//
//  FeelsLikeTableViewCell.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 09.07.2024.
//

import UIKit
import SnapKit

class FeelsLikeTableViewCell: UITableViewCell {
    
    static let reuseID = "FeelsLikeTableViewCell"
    
    private let feelsLikeTempLabelHeader: UILabel = {
        let feelsLikeTempLabelHeader = UILabel()
        feelsLikeTempLabelHeader.text = "Ощущается как:"
        feelsLikeTempLabelHeader.adjustsFontSizeToFitWidth = true
        feelsLikeTempLabelHeader.textAlignment = .left
        return feelsLikeTempLabelHeader
    }()
    
    let feelsLikeTempLabelValue: UILabel = {
        let feelsLikeTempLabelValue = UILabel()
        feelsLikeTempLabelValue.textAlignment = .right
        return feelsLikeTempLabelValue
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Welcome?) {
        guard let model = model else { return }
        feelsLikeTempLabelValue.text = "\(String(format: "%.0f", model.main.feelsLike))°C"
    }
    
    func setupUI() {
        contentView.addSubview(feelsLikeTempLabelHeader)
        contentView.addSubview(feelsLikeTempLabelValue)
        
        feelsLikeTempLabelHeader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
        }
        
        feelsLikeTempLabelValue.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(feelsLikeTempLabelHeader.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}
