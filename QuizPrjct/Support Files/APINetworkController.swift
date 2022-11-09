//
//  APINetworkController.swift
//  Barqia
//
//  Created by Developer on 22/07/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit
import SJFrameSwift


class APINetworkController {
    func callRequest(urlStr: String, completion: @escaping (Array<Dictionary<String, Any>>, Bool) -> Void) {
        let url = URL(string: urlStr)
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        

        let dataTask = URLSession.shared.dataTask(with: request) {
            data,response,error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    if let dictResult = jsonResult["results"] as? Array<Dictionary<String, Any>> {
                        print(jsonResult)
                        //Use GCD to invoke the completion handler on the main thread
                        DispatchQueue.main.async() {
                            completion(dictResult, true)
                        }
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
