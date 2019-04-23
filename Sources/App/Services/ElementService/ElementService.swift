import Vapor

protocol ElementService {
    
    func create(request: Request, elementDto: ElementDto) throws -> Future<ElementDto>
    func fetch(request: Request) throws -> Future<[ElementDto]>
    func delete(request: Request, elementID: Int) throws -> Future<ElementDto>
}
