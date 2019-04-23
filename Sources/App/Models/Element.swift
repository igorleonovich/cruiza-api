import FluentPostgreSQL
import Vapor

final class Element: PostgreSQLModel {
    
    var id: Int?
    var text: String
    var userID: User.ID

    /// Creates a new `Element`.
    init(id: Int? = nil, text: String, userID: User.ID) {
        self.id = id
        self.text = text
        self.userID = userID
    }
}

extension Element {
    
    var user: Parent<Element, User> {
        return self.parent(\.userID)
    }
}

extension Element: Migration { }

extension Element: Content { }

extension Element: Parameter { }
