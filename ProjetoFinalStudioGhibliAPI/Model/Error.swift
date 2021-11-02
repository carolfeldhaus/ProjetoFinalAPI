//
//  Error.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import Foundation

enum SGApiError: Error {
    case emptyReponse
    case notFound
    case emptyData
    case serverError
    case invalidData
 }
