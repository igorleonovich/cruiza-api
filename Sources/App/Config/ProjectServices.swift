import Foundation

enum ProjectServices {
    
    static let userService: UserService = DefaultUserService()
    static let elementService: ElementService = DefaultElementService()
}
