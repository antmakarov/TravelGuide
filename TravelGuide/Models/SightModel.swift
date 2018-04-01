//
//  PlaceModel.swift
//  TravelGuide
//
//  Created by Anton Makarov on 19.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import CoreLocation
import Nuke

var manager = Nuke.Manager.shared

fileprivate struct DataKeys {
    static let id = "id_sight"
    static let name = "name"
    static let type = "type"
    static let rating = "rating"
    static let cost = "cost"
    static let tags = "tags"
    static let coordinate = "coordinate"
    static let imageURL = "photo_urls"
}

struct Sight {
    let id: NSNumber
    let name: String
    let type: String
    let rating: Double
    let cost: Double
    let tags: [String]
    let imagesURL: [String]
    var imagesJPG: [UIImageView]
    let coordinate: CLLocationCoordinate2D
    let reuseIdentifier = "SightCell"
}

// Mark: - extension Sight
extension Sight {
    
    init?(json: Json?) {
        guard let json = json,
            let id = json[DataKeys.id] as? NSNumber,
            let name = json[DataKeys.name] as? String,
            let coordinate = json[DataKeys.coordinate] as? Json
            else {
                return nil
        }
 
        self.id = id
        self.name = name
        self.type = json[DataKeys.type] as? String ?? "None"
        self.rating = json[DataKeys.rating] as? Double ?? 4.0
        self.cost = json[DataKeys.cost] as? Double ?? 0
        self.tags = json[DataKeys.tags] as? [String] ?? []
        self.imagesURL = json[DataKeys.imageURL] as? [String] ?? ["https://img-fotki.yandex.ru/get/197852/27854841.58f/0_ef76b_fb4fa46e_XXXL.jpg"]
        self.imagesJPG = []

        //if let img = imagesURL.first, img != "" {
        //var request = Request(url: URL(string: "")!)
        //manager.loadImage(with: request, into: img)
        
        let lat = (coordinate["lat"] as! NSString).doubleValue
        let long = (coordinate["long"]  as! NSString).doubleValue
        self.coordinate = CLLocationCoordinate2D(latitude: lat as CLLocationDegrees, longitude: long as CLLocationDegrees)
    }
}

