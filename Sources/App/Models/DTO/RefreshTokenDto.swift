import Vapor

struct RefreshTokenDto: Content {
    let refreshToken: String
}
