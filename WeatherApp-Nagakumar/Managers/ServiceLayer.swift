//
//  ServiceLayer.swift
//  NagaKumar-WeatherApp-SwiftUI
//
//  Created by Kalyan Vajrala on 12/3/23.
//

import Foundation
protocol ServiceProtocl {
    
    func fetchData<T:Codable>(url:String,model:T.Type) async throws -> T
}

final class ServiceLayerImpl : ServiceProtocl {
    
    
    func fetchData<T>(url: String, model: T.Type) async throws -> T where T : Decodable, T : Encodable {
        
        guard let unwrappedURL = URL(string: url) else {
           throw NetworkErros.badUrl
        }
        
        let(data,response) =  try await URLSession.shared.data(from: unwrappedURL)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkErros.badResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch {
            throw NetworkErros.decodingError
        }
    }
    
   
    
}


