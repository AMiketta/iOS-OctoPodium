//
//  GetLanguages.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 08/12/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import Foundation

struct Languages {
    
    class Get: Requestable, Parameterless, HTTPGetter {
        
        private static var languages = [Language]()
        
        private var successLangs: (([Language]) -> ())?
        
        var url: String {
            return "\(kUrls.languagesBaseUrl)?sort=popularity"
        }

        func parse(_ json: JSON) -> [Language] {
            return json["languages"] as! [Language]
        }

        func all(callback: @escaping (NetworkResult<[Language]>) -> ()) {

            if Languages.Get.languages.isEmpty {

                call(
                    success: { languages in
                        Languages.Get.languages = languages
                        callback(.success(Languages.Get.languages))
                    },
                    failure: { apiResponse in

                        callback(.failure(apiResponse))
                    }
                )

            } else {
                callback(.success(Languages.Get.languages))
            }
        }

    }
}
