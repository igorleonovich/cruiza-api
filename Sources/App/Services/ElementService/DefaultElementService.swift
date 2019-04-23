import Vapor
import FluentPostgreSQL

struct DefaultElementService: ElementService {
    
    func create(request: Request, elementDto: ElementDto) throws -> Future<ElementDto> {
        return try request.authorizedUser().flatMap { user in
            return Element(text: elementDto.text, userID: try user.requireID()).save(on: request).flatMap { element in
                return request.future(ElementDto(id: try element.requireID(), text: element.text))
            }
        }
    }
    
    func fetch(request: Request) throws -> Future<[ElementDto]> {
        return try request.authorizedUser().flatMap { user in
            return try user.elements.query(on: request).all().flatMap { elements in
                return request.future(try elements.map { ElementDto(id: try $0.requireID(), text: $0.text) })
            }
        }
    }
    
    func delete(request: Request, elementID: Int) throws -> Future<ElementDto> {
        return try request.authorizedUser().flatMap { user in
            return try user
                .elements
                .query(on: request)
                .filter(\.id == elementID)
                .first()
                .unwrap(or: Abort(.badRequest, reason: "User don't have element with id \(elementID)"))
                .delete(on: request)
                .flatMap { element in
                    return request.future(ElementDto(id: try element.requireID(), text: element.text))
            }
        }
    }
}
