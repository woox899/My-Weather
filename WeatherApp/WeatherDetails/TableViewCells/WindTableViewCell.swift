//
//  WindTableViewCell.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 09.07.2024.
//

import UIKit
import SnapKit

class WindTableViewCell: UITableViewCell {
    
    static let reuseID = "WindTableViewCell"
    
    private let windLabelHeader: UILabel = {
        let windLabelHeader = UILabel()
        windLabelHeader.text = "Ветер:"
        windLabelHeader.adjustsFontSizeToFitWidth = true
        windLabelHeader.textAlignment = .left
        return windLabelHeader
    }()
    
    private let windLabelValue: UILabel = {
        let windLabelValue = UILabel()
        windLabelValue.textAlignment = .right
        return windLabelValue
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
        windLabelValue.text = "\(String(model.wind.speed)) м/с"
    }
    
    func setupUI() {
        contentView.addSubview(windLabelHeader)
        contentView.addSubview(windLabelValue)
        
        windLabelHeader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
        }
        
        windLabelValue.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(windLabelHeader.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}
