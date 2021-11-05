//
//  Vehicles.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 05/11/21.
//

import Foundation

class vehicles: Codable {
 
    enum SubstituicoesCodigos : String, CodingKey {
        case id
        case nameVehi
        case descriptionVehi
        case length
        case pilot
    }
    
        var id: String?
        var nameVehi: String?
        var descriptionVehi: String?
        var length: String?
        var pilot: String?
}

/*     {
 "id": "4e09b023-f650-4747-9ab9-eacf14540cfb",
 "name": "Air Destroyer Goliath",
 "description": "A military airship utilized by the government to access Laputa",
 "vehicle_class": "Airship",
 "length": "1,000",
 "pilot": "https://ghibliapi.herokuapp.com/people/40c005ce-3725-4f15-8409-3e1b1b14b583",
 "films": [
     "https://ghibliapi.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe"
 ],
 "url": "https://ghibliapi.herokuapp.com/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb"
}, */
