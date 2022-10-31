//
//  FireBaseFireStoreAccessible.swift
//  Shopping App
//
//  Created by Berkay YAY on 31.10.2022.
//

import Foundation
import FirebaseFirestore

protocol FireBaseFireStoreAccessible {}

extension FireBaseFireStoreAccessible {
    var db: Firestore {
        Firestore.firestore()
    }
}
