//
//  MockFileLoader.swift
//  Weather
//
//  Created by Uma on 29/08/24..
//

import Foundation

struct MockFileLoader {
    static func readDataFromFile<T: Codable>(at filePath: String) -> T {
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: filePath, ofType: "json") else {
            fatalError("FileLoader.readDataFromFile(at \(filePath): file not found path.")
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("FileLoader.readDataFromFile(at \(filePath): Convetion to Data Failed.")
        }
        
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        } catch {
            fatalError("FileLoader.readDataFromFile(at \(filePath): JSON Parse Error")
        }
    }
}
