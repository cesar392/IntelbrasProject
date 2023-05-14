//
//  ViewController.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 10/05/23.
//

import UIKit

protocol ViewDelegate: AnyObject {
    func reloadTableView()
}

class ViewController: UIViewController {

    // MARK: - UIComponents
    @IBOutlet weak var dashboardButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    lazy var viewModel: ViewModel = {
        let viewModel = ViewModel()
        viewModel.viewDelegate = self
        return viewModel
    }()

    // MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchAlarmCentral()
        viewModel.fetchVideoDevice()
    }

    // MARK: - Setup Targets
    @IBAction func didTapDashboard(_ sender: UIButton) { didTapDashboard() }
    @IBAction func didTapFavorite(_ sender: UIButton) { didTapFavorite() }
    @IBAction func didTapVideo(_ sender: UIButton) { didTapVideo() }
    @IBAction func didTapAlarm(_ sender: UIButton) { didTapAlarm() }

    // MARK: - Actions
    private func didTapDashboard() {
        viewModel.removeFilters()
    }

    private func didTapFavorite() {
        viewModel.filterFavorites()
    }

    private func didTapVideo() {
        viewModel.filterVideoDevices()
    }

    private func didTapAlarm() {
        viewModel.filterAlarmCentrals()
    }


    // MARK: - UI Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: DeviceCell.identifier, bundle: nil),
                           forCellReuseIdentifier: DeviceCell.identifier)
    }
}

// MARK: - TableView extension
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.filteredDevices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCell.identifier) as? DeviceCell {
            let currentDevice = viewModel.filteredDevices[indexPath.row]
            cell.setupViewWith(device: currentDevice)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = viewModel.filteredDevices[indexPath.row]
    }
}

// MARK: - ViewDelegate extension
extension ViewController: ViewDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}
