//
//  ServiceLayer.swift
//  NagaKumar-WeatherApp-SwiftUI
//
//  Created by Kalyan Vajrala on 12/3/23.
//

import Foundation

// Protocol defining the service layer interface.
protocol ServiceProtocl {
    func fetchData<T: Codable>(url: String, model: T.Type) async throws -> T
}

// Implementation of the ServiceProtocol.
final class ServiceLayerImpl: ServiceProtocl {
    
    // Function to fetch data from a given URL and decode it into the specified model type.
    func fetchData<T>(url: String, model: T.Type) async throws -> T where T: Decodable, T: Encodable {
        
        // Create a URL from the provided string.
        guard let unwrappedURL = URL(string: url) else {
            throw NetworkErrors.badUrl
        }
        
        // Perform an asynchronous data request.
        let (data, response) = try await URLSession.shared.data(from: unwrappedURL)
        
        // Check if the HTTP response status code is 200 (OK).
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkErrors.badResponse
        }
        
        do {
            // Decode the received data into the specified model type using JSONDecoder.
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkErrors.decodingError
        }
    }
}

// Enum defining network-related errors.
enum NetworkErrors: Error {
    case badUrl
    case badResponse
    case decodingError
}
