//
//  HeaderTableViewCell.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 04.07.2024.
//

import UIKit
import SnapKit

class HeaderTableViewCell: UITableViewCell {
    
    static let reuseID = "WeatherDetailsTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Текущая погода подробно"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
