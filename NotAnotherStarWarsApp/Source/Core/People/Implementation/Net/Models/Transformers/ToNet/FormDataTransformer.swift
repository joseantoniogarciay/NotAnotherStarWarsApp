//
//  FormDataTransformer.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 17/3/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import Foundation

class FormDataTransformer {
    
    static func transform(from photo: Photo, apiName: String) -> FormData {
        return FormData(apiName: apiName, fileName: photo.name, mimeType: photo.mimeType, data: photo.data)
    }

}
