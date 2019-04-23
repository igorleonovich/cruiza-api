import Vapor

final class ElementController {
    
    fileprivate var elementService: ElementService
    
    init(elementService: ElementService) {
        self.elementService = elementService
    }
    
    func fetch(_ req: Request) throws -> Future<[ElementDto]> {
        return try self.elementService.fetch(request: req)
    }

    func create(_ req: Request, elementDto: ElementDto) throws -> Future<ElementDto> {
        return try self.elementService.create(request: req, elementDto: elementDto)
    }

    func delete(_ req: Request) throws -> Future<ElementDto> {
        let elementID = try req.parameters.next(Int.self)
        return try self.elementService.delete(request: req, elementID: elementID)
    }
}

extension ElementController: RouteCollection {
    
    func boot(router: Router) throws {
        let group = router.grouped("v1/element").grouped(JWTMiddleware())
        
        group.post(ElementDto.self, use: self.create)
        group.get(use: self.fetch)
        group.delete(Int.parameter, use: self.delete)
    }
}
