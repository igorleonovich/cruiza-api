import Vapor

protocol UserService {
    
    func signUp(request: Request, user: User) throws -> Future<ResponseDto>
    func signIn(request: Request, user: User) throws -> Future<AccessDto>
    func refreshToken(request: Request, refreshTokenDto: RefreshTokenDto) throws -> Future<AccessDto>
}
