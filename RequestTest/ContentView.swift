//
//  ContentView.swift
//  RequestTest
//
//  Created by Abilio Gambim Parada on 29/01/2020.
//  Copyright © 2020 Abilio Gambim Parada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var requestViewModel = RequestViewModel()
    
    @State private var requestTimes: Double = 1
    
    private var ipDictionary: [String] = []
    
    //Settigns for the request parameters
    private var limitRequest: Double = 1000
    private var stepRequest: Double = 1
    
    init() {
        if let path = Bundle.main.path(forResource: "RequestIps", ofType: "plist"){
            ipDictionary = NSArray(contentsOfFile: path) as! [String]
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Counter: \(requestViewModel.counterRequest)")
                
                ScrollView{
                    Text(requestViewModel.outputRequest)
                }.padding(.bottom, 50)
                
                HStack{
                    Text("Request: \(Int(self.requestTimes))")
                    Slider(value: $requestTimes, in: 1...limitRequest, step: stepRequest)
                        .padding(.horizontal, 24)
                    
                    Button(action: {
                        self.requestViewModel.cleanAllValues()
                        self.requestTimes = 1
                    }) {
                        Text("Clean")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .background(Color.gray, alignment: .leading)
                            .cornerRadius(4)
                            .padding(4)
                    }
                }.padding(.horizontal, 16)
                
                
                VStack{
                    
                    ForEach(ipDictionary, id: \.self) { ip in
                        ButtonRequest(requestViewModel: self.requestViewModel,
                                      color: Color.orange,
                                      url: ip,
                                      label: ip,
                                      requestTime: Int(self.requestTimes))
                    }
                    
                    
                }
            }
        }.navigationBarTitle("Request test")
        
    }
}

struct ButtonRequest: View {
    
    var requestViewModel: RequestViewModel!
    
    var color: Color!
    var url: String!
    var label: String!
    var requestTime: Int!
    
    var body: some View{
        Button(action: {
            self.requestViewModel.cleanAllValues()
            self.requestViewModel.makeRequest(requestUrl: self.url, times: self.requestTime)
        }) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .background(color, alignment: .leading)
                .lineLimit(1)
                .truncationMode(.head)
                .cornerRadius(4)
                .padding(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
