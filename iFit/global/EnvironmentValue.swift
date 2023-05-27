//
//  Environment.swift
//  iFit
//
//  Created by 霍治宇 on 2023/5/7.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var isLogged: Binding<Bool> {
        get { self[IsLoggedKey.self] }
        set { self[IsLoggedKey.self] = newValue }
    }
    
    var localUsername: Binding<String> {
        get { self[UserNameKey.self] }
        set { self[UserNameKey.self] = newValue }
    }
    
//    var localUser: Binding<User> {
//        get { self[LocalUserKey.self] }
//        set { self[LocalUserKey.self] = newValue }
//    }
//    var localUser: User {
//        get { return self[LocalUserKey.self] }
//        set { self[LocalUserKey.self] = newValue }
//    }
}

fileprivate struct IsLoggedKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

fileprivate struct UserNameKey: EnvironmentKey {
    static let defaultValue: Binding<String> =
        .constant("")
}

//fileprivate struct LocalUserKey: EnvironmentKey {
//    static let defaultValue: Binding<User> =
//        .constant(User())
//}

//fileprivate struct LocalUserKey: EnvironmentKey {
//    static let defaultValue: User = User()
//}
