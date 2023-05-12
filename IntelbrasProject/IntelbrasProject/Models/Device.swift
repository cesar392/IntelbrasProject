//
//  Device.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 12/05/23.
//

import Foundation
import UIKit

enum DeviceType {
    case video
    case alarm

    var image: UIImageView {
        switch self {
        case .video:
            return UIImageView()
        case .alarm:
            return UIImageView()
        }
    }
}

protocol Device {
    var name: String { get }
    var type: DeviceType { get }
}
