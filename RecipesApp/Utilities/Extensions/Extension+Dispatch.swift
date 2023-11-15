//
//  Extension+Dispatch.swift
//  RecipesApp
//
//  Created by Jhonatan chavez chavez on 14/11/23.
//

import Foundation

protocol DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
