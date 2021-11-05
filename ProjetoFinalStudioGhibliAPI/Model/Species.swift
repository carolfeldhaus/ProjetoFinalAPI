//
//  Species.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 05/11/21.
//

import Foundation

class species: Codable {
 
    enum SubstituicoesCodigos : String, CodingKey {
        case id
        case nameSpec
        case classification
        case eyeColors
        case hairColors
        case people
    }
    
        var id: String?
        var nameSpec: String?
        var classification: String?
        var eyeColors: String?
        var hairColors: String?
        var people: String?
}



/* [
 {
     "id": "af3910a6-429f-4c74-9ad5-dfe1c4aa04f2",
     "name": "Human",
     "classification": "Mammal",
     "eye_colors": "Black, Blue, Brown, Grey, Green, Hazel",
     "hair_colors": "Black, Blonde, Brown, Grey, White",
     "people": [
         "https://ghibliapi.herokuapp.com/people/ba924631-068e-4436-b6de-f3283fa848f0",
         "https://ghibliapi.herokuapp.com/people/e9356bb5-4d4a-4c93-aadc-c83e514bffe3",
         "https://ghibliapi.herokuapp.com/people/34277bec-7401-43fa-a00a-5aee64b45b08",
         "https://ghibliapi.herokuapp.com/people/91939012-90b9-46e5-a649-96b898073c82",
         "https://ghibliapi.herokuapp.com/people/20e3bd33-b35d-41e6-83a4-57ca7f028d38",
         "https://ghibliapi.herokuapp.com/people/8bccdc78-545b-49f4-a4c8-756163a38c91",
         "https://ghibliapi.herokuapp.com/people/116bfe1b-3ba8-4fa0-8f72-88537a493cb9",
         "https://ghibliapi.herokuapp.com/people/986faac6-67e3-4fb8-a9ee-bad077c2e7fe",
         "https://ghibliapi.herokuapp.com/people/d5df3c04-f355-4038-833c-83bd3502b6b9",
         "https://ghibliapi.herokuapp.com/people/3031caa8-eb1a-41c6-ab93-dd091b541e11",
         "https://ghibliapi.herokuapp.com/people/87b68b97-3774-495b-bf80-495a5f3e672d",
         "https://ghibliapi.herokuapp.com/people/08ffbce4-7f94-476a-95bc-76d3c3969c19",
         "https://ghibliapi.herokuapp.com/people/0f8ef701-b4c7-4f15-bd15-368c7fe38d0a",
         "https://ghibliapi.herokuapp.com/people/2409052a-9029-4e8d-bfaf-70fd82c8e48d",
         "https://ghibliapi.herokuapp.com/people/8228751c-bdc1-4b8d-a6eb-ca0eb909568f",
         "https://ghibliapi.herokuapp.com/people/1c1a8054-3a34-4185-bfcf-e8011506f09a",
         "https://ghibliapi.herokuapp.com/people/bc838920-7849-43ea-bfb8-7d5e98dc20b6",
         "https://ghibliapi.herokuapp.com/people/d1de1c0e-3fcd-4cef-94eb-bb95cc2314aa",
         "https://ghibliapi.herokuapp.com/people/33f5fea9-c21b-490b-90e0-c4051c372826"
     ], */
