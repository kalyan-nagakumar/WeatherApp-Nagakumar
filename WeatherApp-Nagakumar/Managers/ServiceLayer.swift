//
//  ServiceLayer.swift
//  NagaKumar-WeatherApp-SwiftUI
//
//  Created by Kalyan Vajrala on 12/3/23.
//

import Foundation
protocol ServiceProtocl {
    func fetchData<T:Codable>(url:String,resultModel:T) async throws
}

class ServiceLayer : ServiceProtocl {
    
    
    
    func fetchData<T>(url: String, resultModel: T) async throws where T : Decodable, T : Encodable {
        
        guard let unwrappedURL = URL(string: url) else {return}
        
        let(data,response) =  try await URLSession.shared.data(from: unwrappedURL)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {return}
        
        guard let responseData = try? JSONDecoder().decode(T.self, from: data) else {return}
        
        
        
    }
    
    
    
    
    
}
