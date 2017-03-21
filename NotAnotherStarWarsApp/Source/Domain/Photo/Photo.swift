//
//  Photo.swift
//  NotAnotherStarWarsApp
//
//  Created by Jose Antonio García Yañez on 17/3/17.
//  Copyright © 2017 RocketSolutions. All rights reserved.
//

import UIKit

class Photo: NSObject {
    let name: String
    let mimeType: String
    let data: Data
    
    private init(builder: Builder) {
        name = builder.name
        mimeType = builder.mimeType
        data = builder.data
    }
    
    public class Builder {
        var name: String = ""
        var mimeType: String = ""
        var data: Data = Data()

        func setName(_ name: String) -> Builder {
            self.name = name
            return self
        }
        
        func setMimeType(_ mimeType: String) -> Builder {
            self.mimeType = mimeType
            return self
        }
        
        func setData(_ data: Data) -> Builder {
            self.data = data
            return self
        }
        
        func build() -> Photo? {
            guard self.name != "", self.mimeType != "", !self.data.isEmpty else { return nil }
            return Photo(builder: self)
        }
        
    }
    
}
