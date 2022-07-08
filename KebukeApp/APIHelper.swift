//
//  APIHelper.swift
//  KebukeApp
//
//  Created by Sara Yang on 2022/7/6.
//

import Foundation

public class APIHelper {
    typealias CompletionHandler = (_ success: Bool, _ data: String?) -> Void
   
    
    func getList(_ url: URL, _ header : [String: String], completionHandler:  @escaping CompletionHandler) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (key, value) in header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data , let content = String(data: data, encoding: .utf8)
            {
                completionHandler(true, content)
         
            } else {
                completionHandler(false, nil)
            }
        }.resume()
       
    }
    
   
    
}
