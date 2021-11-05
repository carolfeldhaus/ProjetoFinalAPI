//
//  Locations.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 05/11/21.
//

import Foundation

class locations: Codable {
 
    enum SubstituicoesCodigos : String, CodingKey {
        case id
        case nameLoc
        case climate
        case terrain
        case surfaceWater
        case residents
    }
    
        var id: String?
        var nameLoc: String?
        var climate: String?
        var terrain: String?
        var surfaceWater: String?
        var residents: String?
}



/* [
 {
     "id": "11014596-71b0-4b3e-b8c0-1c4b15f28b9a",
     "name": "Irontown",
     "climate": "Continental",
     "terrain": "Mountain",
     "surface_water": "40",
     "residents": [
         "https://ghibliapi.herokuapp.com/people/ba924631-068e-4436-b6de-f3283fa848f0",
         "https://ghibliapi.herokuapp.com/people/030555b3-4c92-4fce-93fb-e70c3ae3df8b"
     ],
     "films": [
         "https://ghibliapi.herokuapp.com/films/0440483e-ca0e-4120-8c50-4c8cd9b965d6"
     ],
     "url": "https://ghibliapi.herokuapp.com/locations/11014596-71b0-4b3e-b8c0-1c4b15f28b9a"
 }, */
