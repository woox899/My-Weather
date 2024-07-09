//
//  AtmospherePressureTableViewCell.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 09.07.2024.
//

import UIKit
import SnapKit

class AtmospherePressureTableViewCell: UITableViewCell {
    
    static let reuseID = "AtmospherePressureTableViewCell"
    
    private let atmospherePressureLabelHeader: UILabel = {
        let atmospherePressureLabelHeader = UILabel()
        atmospherePressureLabelHeader.text = "Атмосферное давление:"
        atmospherePressureLabelHeader.adjustsFontSizeToFitWidth = true
        atmospherePressureLabelHeader.textAlignment = .left
        return atmospherePressureLabelHeader
    }()
    
   private let atmospherePressureLabelValue: UILabel = {
        let atmospherePressureLabelValue = UILabel()
        atmospherePressureLabelValue.textAlignment = .right
        return atmospherePressureLabelValue
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
        atmospherePressureLabelValue.text = "\(String(format: "%.00f", model.main.grndLevel / 1.333)) мм рт. ст."
    }
    
    func setupUI() {
        contentView.addSubview(atmospherePressureLabelHeader)
        contentView.addSubview(atmospherePressureLabelValue)
        
        atmospherePressureLabelHeader.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
        }
        
        atmospherePressureLabelValue.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(atmospherePressureLabelHeader.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
}
