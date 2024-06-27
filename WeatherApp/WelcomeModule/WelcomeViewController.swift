//
//  ViewController.swift
//  WeatherApp
//
//  Created by Андрей Бабкин on 17.06.2024.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController, UISearchTextFieldDelegate {

    var viewModel: WelcomeViewModelProtocol

    var inputText: String = ""

    private let logo: UILabel = {
        let logo = UILabel()
        logo.text = "Weather App"
        logo.font = UIFont.boldSystemFont(ofSize: 32)
        logo.textColor = .white
        logo.textAlignment = .center
        return logo
    }()

    private lazy var searchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField()
        searchTextField.delegate = self
        searchTextField.backgroundColor = .white
        return searchTextField
    }()

    private lazy var showButton: UIButton = {
        let showButton = UIButton()
        showButton.setTitle("Show", for: .normal)
        showButton.setTitleColor(.black, for: .normal)
        showButton.layer.cornerRadius = 8
        showButton.backgroundColor = .white
        showButton.addTarget(self, action: #selector(goToShowWeatherViewController), for: .touchUpInside)
        return showButton
    }()

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        inputText = text
        return true
     }

    @objc func goToShowWeatherViewController() {
        let viewModel: ShowWeatherViewModelProtocol = ShowWeatherViewModel(query: inputText)
        let showWeatherViewController = ShowWeatherViewController(viewModel: viewModel, location: inputText)
        navigationController?.pushViewController(showWeatherViewController, animated: true)
    }
    
    init(viewModel: WelcomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        view.backgroundColor = UIColor(red: 39/255, green: 41/255, blue: 48/255, alpha: 1)

        view.addSubview(logo)
        view.addSubview(searchTextField)
        view.addSubview(showButton)

        logo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(200)
            make.width.equalTo(view.frame.width * 0.8)
            make.height.equalTo(30)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logo.snp.bottom).offset(30)
            make.width.equalTo(view.frame.width * 0.73)
            make.height.equalTo(30)
        }
        
        showButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).offset(100)
            make.height.equalTo(45)
            make.width.equalTo(view.frame.width * 0.62)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

