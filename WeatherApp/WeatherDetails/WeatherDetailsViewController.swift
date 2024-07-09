//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 04.07.2024.
//

import UIKit
import SnapKit

enum SectionsType {
    case first
}

enum RowsType {
    case header
    case temperature
    case feelsLike
    case atmospherePressure
    case humidity
    case wind
}

struct TebleViewCellsType {
    let sections: SectionsType
    let rows: [RowsType]
}

class WeatherDetailsViewController: UIViewController {
    
    private let sectionsAndRows: [TebleViewCellsType] = [.init(sections: SectionsType.first, rows: [.header, .temperature, .feelsLike, .atmospherePressure, .humidity, .wind])]
    
    var model: Welcome?
    
    var viewModel: WeatherDetailsViewModelProtocol
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.reuseID)
        view.register(TemperatureTableViewCell.self, forCellReuseIdentifier: TemperatureTableViewCell.reuseID)
        view.register(FeelsLikeTableViewCell.self, forCellReuseIdentifier: FeelsLikeTableViewCell.reuseID)
        view.register(AtmospherePressureTableViewCell.self, forCellReuseIdentifier: AtmospherePressureTableViewCell.reuseID)
        view.register(HumidityTableViewCell.self, forCellReuseIdentifier: HumidityTableViewCell.reuseID)
        view.register(WindTableViewCell.self, forCellReuseIdentifier: WindTableViewCell.reuseID)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(viewModel: WeatherDetailsViewModelProtocol, model: Welcome?) {
        self.viewModel = viewModel
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension WeatherDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionsAndRows[0].rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsAndRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell {
            switch sectionsAndRows[indexPath.section].rows[indexPath.row] {
            case .header:
                guard let headerTableViewCell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.reuseID, for: indexPath) as? HeaderTableViewCell  else { return UITableViewCell() }
                return headerTableViewCell
            case .temperature:
                guard let temperatureTableViewCell = tableView.dequeueReusableCell(withIdentifier: TemperatureTableViewCell.reuseID, for: indexPath) as? TemperatureTableViewCell else { return UITableViewCell() }
                temperatureTableViewCell.configure(model: model)
                return temperatureTableViewCell
            case .feelsLike:
                guard let feelsLikeTabeViewCell = tableView.dequeueReusableCell(withIdentifier: FeelsLikeTableViewCell.reuseID, for: indexPath) as? FeelsLikeTableViewCell else { return UITableViewCell() }
                feelsLikeTabeViewCell.configure(model: model)
                return feelsLikeTabeViewCell
            case .atmospherePressure:
                guard let atmospherePressureTableViewCell = tableView.dequeueReusableCell(withIdentifier: AtmospherePressureTableViewCell.reuseID, for: indexPath) as? AtmospherePressureTableViewCell else { return UITableViewCell() }
                atmospherePressureTableViewCell.configure(model: model)
                return atmospherePressureTableViewCell
            case .humidity:
                guard let humidityTableViewCell = tableView.dequeueReusableCell(withIdentifier: HumidityTableViewCell.reuseID, for: indexPath) as? HumidityTableViewCell else { return UITableViewCell() }
                humidityTableViewCell.configure(model: model)
                return humidityTableViewCell
            case .wind:
                guard let windTableViewCell = tableView.dequeueReusableCell(withIdentifier: WindTableViewCell.reuseID, for: indexPath) as? WindTableViewCell else { return UITableViewCell() }
                windTableViewCell.configure(model: model)
                return windTableViewCell
            default:
                return UITableViewCell()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension WeatherDetailsViewController: UITableViewDelegate {
    
}
