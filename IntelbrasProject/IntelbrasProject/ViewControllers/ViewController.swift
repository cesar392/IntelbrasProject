//
//  ViewController.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 10/05/23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var dashboardButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!

    lazy var devicesList: [Device] = {
        var deviceList = [Device]()
        deviceList.append(contentsOf: AlarmCentral.getMockAlarmCentrals())
        deviceList.append(contentsOf: VideoDevice.getMockVideoDevices())
        return deviceList
    }()

    // MARK: - UIComponents


    // MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Setup Targets
    @IBAction func didTapDashboard(_ sender: Any) { didTapDashboard() }
    @IBAction func didTapFavorite(_ sender: Any) {  didTapFavorite() }
    @IBAction func didTapVideo(_ sender: Any) { didTapVideo() }
    @IBAction func didTapAlarm(_ sender: Any) { didTapAlarm() }

    // MARK: - Setup Actions
    private func didTapDashboard() {
    }

    private func didTapFavorite() {
    }

    private func didTapVideo() {
    }

    private func didTapAlarm() {
    }


    // MARK: - UI Setup

}
