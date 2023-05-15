//
//  CreateDeviceViewController.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 14/05/23.
//

import Foundation
import RxSwift
import UIKit

class CreateDeviceViewController: UIViewController {

    // MARK: - UIComponents
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var serialTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: - Variables
    private let viewModel: CreateDeviceViewModel = ViewModelFactory.getCreateDevicesViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - UIComponents
    @IBAction func didTapSaveButton(_ sender: UIButton) { self.didTapSaveButton() }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
    }

    // MARK: - Actions
    private func didTapSaveButton() {
        if let name = nameTextField.text,
           let serial = serialTextField.text,
           let username = usernameTextField.text,
           let password = passwordTextField.text,
           serial.count < Constants.minimumSerialLength {
            viewModel.onSaveButtonSelected(name: name, serial: serial, username: username, password: password)
        } else {
            // TODO: Handle error: missing/wrong parameters
        }
    }

    // MARK: - Methods
    func setupObservers() {
        viewModel.onSaveSucceeded.subscribe(onCompleted: {
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
}
