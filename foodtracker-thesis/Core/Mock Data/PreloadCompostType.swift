//
//  PreloadCompostType.swift
//  foodtracker-thesis
//
//  Created by Audrey Aurelia Chang on 09/02/22.
//

import Foundation
import UIKit

func preloadCompostType(){
    CompostTypeRepository.shared.createCompostType(compost_type_id: 0, compost_type_name: "Compost")
    CompostTypeRepository.shared.createCompostType(compost_type_id: 1, compost_type_name: "Ecoenzym")
}
