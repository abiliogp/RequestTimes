//
//  RequestViewModel.swift
//  RequestTest
//
//  Created by Abilio Gambim Parada on 29/01/2020.
//  Copyright © 2020 Abilio Gambim Parada. All rights reserved.
//

import Foundation

class RequestViewModel: ObservableObject{
    
    @Published var outputRequest = String()
    @Published var counterRequest = Int()
    
    func makeRequest(requestUrl: String, times: Int = 1000){
        guard let url = URL(string: requestUrl) else { return }
        
        for _ in 1...times {
            URLSession.shared.dataTask(with: url) { (data, resp, error) in
                DispatchQueue.main.async {
                    if let data = data{
                        self.outputRequest = String(data: data, encoding: .ascii)!
                        self.counterRequest = self.counterRequest + 1
                    } else{
                        self.outputRequest = error.debugDescription
                    }
                }
            }.resume()
        }
    }
    
    func cleanAllValues(){
        self.outputRequest = String()
        self.counterRequest = Int()
    }
}
