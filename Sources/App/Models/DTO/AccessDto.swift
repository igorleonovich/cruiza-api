import Vapor

struct AccessDto: Content {
    let refreshToken: String
    let accessToken: String
    let expiredAt: Date
}
