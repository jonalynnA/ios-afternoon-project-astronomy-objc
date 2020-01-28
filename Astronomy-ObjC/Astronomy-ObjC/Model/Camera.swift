//
//  Camera.swift
//  Astronomy-ObjC
//
//  Created by Jonalynn Masters on 1/27/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import Foundation

@objc(Camera)
class Camera: NSObject {
    let id: Int
    let name: String
    let roverId: Int
    let fullName: String

    @objc init(id: Int, name: String, roverId: Int, fullName: String) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.roverId = roverId
    }
}
