import FluentPostgreSQL
import Vapor

final class User: PostgreSQLModel {
    
    var id: Int?
    var login: String
    var password: String
    
    init(id: Int? = nil, login: String, password: String) {
        self.id = id
        self.login = login
        self.password = password
    }
}

extension User {
    
    var elements: Children<User, Element> {
        return self.children(\.userID)
    }
    
    var refreshTokens: Children<User, RefreshToken> {
        return self.children(\.userID)
    }
}

extension User: Migration {
    
    static func prepare(on conn: PostgreSQLConnection) -> Future<Void> {
        return Database.create(User.self, on: conn, closure: { builder in
            try self.addProperties(to: builder)
            
            builder.unique(on: \.login)
        })
    }
}

extension User: Content { }

extension User: Parameter { }
