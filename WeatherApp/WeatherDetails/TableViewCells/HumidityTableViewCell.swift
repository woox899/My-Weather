//
//  HumidityTableViewCell.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 09.07.2024.
//

import UIKit
import SnapKit

class HumidityTableViewCell: UITableViewCell {
    
    static let reuseID = "HumidityTableViewCell"
    
    private let humidityLabelHeader: UILabel = {
        let humidityLabelHeader = UILabel()
        humidityLabelHeader.text = "Влажность:"
        humidityLabelHeader.adjustsFontSizeToFitWidth = true
        humidityLabelHeader.textAlignment = .left
        return humidityLabelHeader
    }()
    
    private let humidityLabelValue: UILabel = {
        let humidityLabelValue = UILabel()
        humidityLabelValue.textAlignment = .right
        return humidityLabelValue
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
        humidityLabelValue.text = "\(String(model.main.humidity))%"
    }
    
    func setupUI() {
        contentView.addSubview(humidityLabelHeader)
        contentView.addSubview(humidityLabelValue)
        
        humidityLabelHeader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
        }
        
        humidityLabelValue.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(humidityLabelHeader.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}
