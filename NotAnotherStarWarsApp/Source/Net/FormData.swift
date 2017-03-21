//
//  FormData.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 13/3/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class FormData {
    
    let apiName : String
    let fileName : String
    let mimeType : String
    let data : Data
    
    init(apiName : String, fileName : String, mimeType: String, data: Data) {
        self.apiName = apiName
        self.fileName = fileName
        self.mimeType = mimeType
        self.data = data
    }
    
}
