//
//  EditImpormation.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/31.
//

import Foundation

struct PostImpormation: Editable {
    var essentialElement: EditEssentialElement = .post
    var requestAPI: Requestable
    
    init(parameter: [String: Any], image: [Media]) {
        requestAPI = PostAPI(parameter: parameter, image: image)
    }
}

struct PatchImpormation: Editable {
    var essentialElement: EditEssentialElement = .patch
    var requestAPI: Requestable
    
    init(id: Int, parameter: [String: Any], image: [Media]) {
        requestAPI = PatchAPI(id: id, parameter: parameter, image: image)
    }
}
