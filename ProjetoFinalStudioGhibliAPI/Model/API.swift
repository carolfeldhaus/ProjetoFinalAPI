//
//  API.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import Foundation

struct API {
    
//inserindo as urls da api
  let baseURL = "https://ghibliapi.herokuapp.com"
    
    var setSGURL: String {
        return "\(baseURL)/\(EndPoints.films)"
    }
    
    func setPeopleSGURL() -> String {
        return "\(baseURL)/\(EndPoints.people)"
    }
    
    func setLocationsSGURL() -> String {
        return "\(baseURL)/\(EndPoints.locations)"
    }
    
    func setSpeciesSGURL() -> String {
        return "\(baseURL)/\(EndPoints.species)"
    }
    
    func setVehiclesURL() -> String {
        return "\(baseURL)/\(EndPoints.vehicles)"
    }
    
//fazendo o get da api
    func getSG(urlString: String, method: HTTPMetodo = HTTPMetodo.GET, response: @escaping ([studioGhibli]?, SGApiError?) -> Void) {
        
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        
        guard let url: URL = URL(string: urlString) else { return }
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "\(method)"
       
        let task = session.dataTask(with: urlRequest, completionHandler: { (result, urlResponse, error) in
            var statusCode: Int = 0
            
            if let response = urlResponse as? HTTPURLResponse {
                statusCode = response.statusCode
            }
            
            guard let data = result else {
                
//fazendo os erros
                response(nil, SGApiError.emptyReponse)
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let decodableData: [studioGhibli] = try decoder.decode([studioGhibli].self, from: data)
                if decodableData.count < 1 {
                    response(nil, SGApiError.emptyArray)
                }
                
                switch statusCode {
                case 200:
                    response(decodableData, nil)
                case 404:
                    response(nil, SGApiError.notFound)
                    return
                case 500:
                    response(nil, SGApiError.serverError)
                    return
                default:
                    break
                }
                
            } catch {
                response(nil, SGApiError.invalidResponse)
            }
        })
        task.resume()
    }
}
