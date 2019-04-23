import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // MARK: - ElementController
    
    let elementController = ElementController(elementService: ProjectServices.elementService)
    
    try router.register(collection: elementController)
    
    // MARK: - UserController
    
    let userController = UserController(userService: ProjectServices.userService)
    
    try router.register(collection: userController)
}
