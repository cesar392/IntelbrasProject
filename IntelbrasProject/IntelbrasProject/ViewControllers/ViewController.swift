//
//  ViewController.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 10/05/23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UIComponents
    @IBOutlet weak var dashboardButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    let viewModel = ViewModel()

    // MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchAlarmCentral() {
            self.tableView.reloadData()
        }
        viewModel.fetchVideoDevice() {
            self.tableView.reloadData()
        }
    }

    // MARK: - Setup Targets
    @IBAction func didTapDashboard(_ sender: Any) { didTapDashboard() }
    @IBAction func didTapFavorite(_ sender: Any) { didTapFavorite() }
    @IBAction func didTapVideo(_ sender: Any) { didTapVideo() }
    @IBAction func didTapAlarm(_ sender: Any) { didTapAlarm() }

    // MARK: - Actions
    private func didTapDashboard() {
    }

    private func didTapFavorite() {
    }

    private func didTapVideo() {
    }

    private func didTapAlarm() {
    }


    // MARK: - UI Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: DeviceCell.identifier, bundle: nil),
                           forCellReuseIdentifier: DeviceCell.identifier)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.devicesList.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCell.identifier) as? DeviceCell {
            let currentDevice = viewModel.devicesList[indexPath.row]
            cell.setupViewWith(device: currentDevice)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
