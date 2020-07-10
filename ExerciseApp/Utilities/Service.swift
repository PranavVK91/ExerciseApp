//
//  Service.swift
//  ExerciseApp
//
//  Created by Pranav V K on 09/07/20.
//  Copyright © 2020 Pranav V K. All rights reserved.
//

import Foundation

/*
 Method to make webservice call. Expecting string url as parameter and returns responce in Data format.
 This method can be used for other api's as well.
 */
func makeWebServiceCall(from url: String, successHandler: @escaping(String, Data) -> Void, failureHandler: @escaping() -> Void) {
    guard let url = makeUrlFromString(stringUrl: url) else { return }
    URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
        guard let data = data, error == nil else {
            failureHandler()
            return
        }
        
        let stringData = String(decoding: data, as: UTF8.self)
        guard let utf8Data = stringData.data(using: .utf8) else {
            failureHandler()
            return
        }
        successHandler("Success", utf8Data)
    }).resume()
}
