//
//  SatDataService.swift
//  2023_01_17-DarinBurch--NYCSchools
//
//  Created by Mapspot on 1/17/23.
//

import Foundation



class SatDataService {
    
    static func loadSatData(dbn: String) async throws -> [SatScore] {
        guard let url = URL(string: Ref.SAT_ENDPOINT(dbn: dbn)) else {
            throw ResponseError.urlBuildError("Url build error")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let httpResponse = response as? HTTPURLResponse
        if !(200...299).contains(httpResponse!.statusCode) {
            do {
                let errorResponse = try JSONDecoder().decode(ErrorMessage.self, from: data)
                throw ResponseError.badRequest("\(errorResponse)")
            } catch {
                throw ResponseError.decodingError(error.localizedDescription)
            }
        }
        
        do {
            let scores = try JSONDecoder().decode([SatScore].self, from: data)
            print("S",scores)
            return scores
            
        } catch {
            throw ResponseError.decodingError(error.localizedDescription)
        }
    }
    
}
