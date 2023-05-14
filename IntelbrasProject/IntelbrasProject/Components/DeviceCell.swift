//
//  DeviceCell.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 13/05/23.
//

import UIKit

class DeviceCell: UITableViewCell {

    static let identifier = "DeviceCell"

    // MARK: - UIComponents
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var mainContainer: UIView!

    // MARK: - LifeCyle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Setup
    internal func setupViewWith(device: BaseDevice) {
        self.mainContainer.layer.borderColor = UIColor.customLightGray.cgColor
        self.mainContainer.layer.cornerRadius = Constants.defaultCornerRadius
        self.iconImage.image = device.getImage()
        self.nameLabel.text = device.name
        self.clipsToBounds = true
    }

    // MARK: - Actions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
