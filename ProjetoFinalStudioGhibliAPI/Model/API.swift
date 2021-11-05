//
//  API.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import Foundation

class API: sGAPI {
    
//inserindo as urls da api
  let baseURL = "https://ghibliapi.herokuapp.com"
    
    func setSGURL() -> String {
        return "\(baseURL)/\(EndPoints.films)"
    }
    
//fazendo o get da api
    func getSG(urlString: String, method: HTTPMetodo, completion: @escaping (Result<[studioGhibli], SGApiError>) -> Void) {
        
        // Criando array
        var _: [studioGhibli] = []

        // Criando request HTTP
        // Criando config da sessão
        let config: URLSessionConfiguration = .default

        // Contruindo a sessão
        let session: URLSession = URLSession(configuration: config)

        // Criando a URL
        guard let url: URL = URL(string: urlString) else {
            return
        }

        // URL request
        let urlRequest: URLRequest = URLRequest(url: url)

        let task = session.dataTask(with: urlRequest) { result, urlResponse, error in

            var statusCode: Int = 0
            if let response = urlResponse as? HTTPURLResponse {
                statusCode = response.statusCode
                print(statusCode)
            }

            guard let data = result else {
                completion(Result.failure(SGApiError.emptyData))
                return
            }

            do {
                
                // Criando um decoder
                let decoder: JSONDecoder = JSONDecoder()
                
                // Decodificar
                let decodeData: [studioGhibli] = try decoder.decode([studioGhibli].self, from: data)

                switch statusCode {
                
                //tudo ok e funcionando
                case 200:
                    //completion(Result.success(decodeData))
                    completion(Result.failure(SGApiError.serverError))
                
                //Not found - nao encontrado
                case 404:
                    completion(Result.failure(SGApiError.notFound))
                
                //Internet server error
                case 500:
                    completion(Result.failure(SGApiError.serverError))
                default:
                    break
                }
            } catch {
                completion(Result.failure(SGApiError.invalidData))
            }
        }
        task.resume()
    }
}

