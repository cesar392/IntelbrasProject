//
//  ViewController.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 10/05/23.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    // MARK: - UIComponents
    @IBOutlet weak var dashboardButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    //    Should come from APPFactory
    lazy var viewModel: ViewModel = {
        let acRepository = AlarmCentralRepository(token: Constants.API_TOKEN)
        let vdRepository = VideoDeviceRepository(token: Constants.API_TOKEN)
        let favoritesRepository = InMemoryFavoriteRepository()
        let favoriteService = FavoritesService(favoriteRepo: favoritesRepository)
        let nwService = DeviceService(alarmCentralRepository: acRepository,
                                      videoDeviceRepository: vdRepository,
                                      favoritesRepository: favoritesRepository)
        let viewModel = ViewModel(deviceService: nwService, favoriteService: favoriteService)
        return viewModel
    }()

    var filteredDevices = [Device]()
    let disposeBag = DisposeBag()

    // MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        observeData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadInitialData()
    }

    // MARK: - Setup Targets
    @IBAction func didTapDashboard(_ sender: UIButton) { didTapDashboard() }
    @IBAction func didTapFavorite(_ sender: UIButton) { didTapFavorite() }
    @IBAction func didTapVideo(_ sender: UIButton) { didTapVideo() }
    @IBAction func didTapAlarm(_ sender: UIButton) { didTapAlarm() }

    private func observeData() {
        viewModel.filteredDevices.subscribe(
            onNext: { [weak self] devices in
                self?.filteredDevices = devices
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.filter.subscribe(onNext: { [weak self] filter in
            self?.resetButtons()
            let activeButton = self?.getButton(from: filter)
            activeButton?.tintColor = .colorPrimary
        }).disposed(by: disposeBag)
    }

    private func getButton(from filter: DeviceFilter) -> UIButton {
        switch filter {
        case .all:
            return dashboardButton
        case.favorites:
            return favoriteButton
        case .videoDevices:
            return videoButton
        case .alarmCentrals:
            return alarmButton
        }
    }

    private func resetButtons() {
        dashboardButton.tintColor = .customLightGray
        favoriteButton.tintColor = .customLightGray
        videoButton.tintColor = .customLightGray
        alarmButton.tintColor = .customLightGray
    }

    // MARK: - Actions
    private func didTapDashboard() {
        viewModel.onDashboardSelected()
    }

    private func didTapFavorite() {
        viewModel.onFavoritesSelected()
    }

    private func didTapVideo() {
        viewModel.onVideoDevicesSelected()
    }

    private func didTapAlarm() {
        viewModel.onAlarmCentralsSelected()
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
        return self.filteredDevices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCell.identifier) as? DeviceCell {
            let currentDevice = filteredDevices[indexPath.row]
            cell.setupViewWith(device: currentDevice)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = filteredDevices[indexPath.row]
        viewModel.toggleFavorite(device: device)
    }
}
