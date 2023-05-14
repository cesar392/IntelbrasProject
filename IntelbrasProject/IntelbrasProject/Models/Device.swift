//
//  Device.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 12/05/23.
//

import Foundation
import UIKit

enum DeviceType: Codable {
    case video
    case alarm

    var image: UIImage? {
        switch self {
        case .video:
            return R.image.icVideoDevice()
        case .alarm:
            return R.image.icAlarmDevice()
        }
    }
}

protocol Device {
    var name: String { get set }
    func getImage() -> UIImage?
}
