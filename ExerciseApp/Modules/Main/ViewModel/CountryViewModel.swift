//
//  CountryViewModel.swift
//  ExerciseApp
//
//  Created by Pranav V K on 09/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import Foundation

final class CountryViewModel: NSObject {
    var countryModel: CountryModel?
    
    func loadData(handler: @escaping(Bool) -> Void) {
        makeWebServiceCall(from: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", successHandler: { status, data in
            do {
                self.countryModel = try JSONDecoder().decode(CountryModel.self, from: data)
                handler(true)
            } catch let error as NSError {
                print("API failure: \(error.description)")
                handler(false)
            }
        }, failureHandler: {
            handler(false)
        })
    }
}
