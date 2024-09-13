//
//  TemperatureTableViewCell.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 05.07.2024.
//

import UIKit
import SnapKit

class TemperatureTableViewCell: UITableViewCell {
    
    static let reuseID = "TemperatureTableViewCell"
    
    private let temparatureLabelHeader: UILabel = {
        let temparatureLabelHeader = UILabel()
        temparatureLabelHeader.text = "Температура окружающего воздуха:"
        temparatureLabelHeader.adjustsFontSizeToFitWidth = true
        temparatureLabelHeader.textAlignment = .left
        temparatureLabelHeader.font = .systemFont(ofSize: 16)
        return temparatureLabelHeader
    }()
    
    let temparatureValueLabel: UILabel = {
        let temparatureValueLabel = UILabel()
        temparatureValueLabel.textAlignment = .right
        return temparatureValueLabel
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
        temparatureValueLabel.text = "\(String(format: "%.0f", model.main.temp))°C"
    }
    
    func setupUI() {
        contentView.addSubview(temparatureLabelHeader)
        contentView.addSubview(temparatureValueLabel)
        
        temparatureLabelHeader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
        }
        
        temparatureValueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(temparatureLabelHeader.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}
