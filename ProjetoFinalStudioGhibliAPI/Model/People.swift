//
//  People.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 04/11/21.
//

import Foundation

class people: Codable {
 
    enum SubstituicoesCodigos : String, CodingKey {
        case id
        case name
        case gender
        case age
        case eyeColor
        case hairColor
    }
    
        var id: String?
        var name: String?
        var gender: String?
        var age: String?
        var eyeColor: String?
        var hairColor: String?    
}


 /* {
    "id": "267649ac-fb1b-11eb-9a03-0242ac130003",
    "name": "Haku",
    "gender": "Male",
    "age": "12",
    "eye_color": "Green",
    "hair_color": "Green",
    "films": [
        "https://ghibliapi.herokuapp.com/films/dc2e6bd1-8156-4886-adff-b39e6043af0c"
    ],
    "species": "https://ghibliapi.herokuapp.com/species/e2cfaa78-fb19-11eb-9a03-0242ac130003",
    "url": "https://ghibliapi.herokuapp.com/people/267649ac-fb1b-11eb-9a03-0242ac130003"
}, */
