//
//  CountryViewModel.swift
//  ExerciseApp
//
//  Created by Pranav V K on 09/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import Foundation
import UIKit

final class CountryViewModel: NSObject {
    var countryModel: CountryModel?
    var numberOfRows: Int {
        self.countryModel?.details.count ?? 0
    }
    
    func loadData(handler: @escaping(Bool) -> Void) {
        makeWebServiceCall(from: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", successHandler: { status, data in
            do {
                var modelData = try JSONDecoder().decode(CountryModel.self, from: data)
                modelData.details = modelData.details.filter{ $0.title != nil || $0.description != nil || $0.imageUrl != nil}
                self.countryModel = modelData
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
