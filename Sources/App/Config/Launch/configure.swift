import FluentPostgreSQL
import Vapor
import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // MARK: - Router
    
    let router = EngineRouter.default()
    
    try routes(router)
    
    services.register(router, as: Router.self)
    
    // MARK: - Directory
    
    let directoryConfig = DirectoryConfig.detect()
    
    services.register(directoryConfig)
    
    // MARK: - Middlewares
    
    var middlewares = MiddlewareConfig()
    
    middlewares.use(ErrorMiddleware.self)
    
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let corsMiddleware = CORSMiddleware(configuration: corsConfiguration)
    middlewares.use(corsMiddleware)
    
    services.register(middlewares)
    
    // MARK: - Leaf
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    // MARK: - PostgreSQL
    
    try services.register(FluentPostgreSQLProvider())
    let postgresqlConfig = PostgreSQLDatabaseConfig(
        hostname: "localhost",
        port: 5432,
        username: "test",
        database: "spaceground",
        password: nil
    )
    services.register(postgresqlConfig)
    
    // MARK: - Migration
    
    var migrations = MigrationConfig()
    
    migrations.add(model: Element.self, database: .psql)
    migrations.add(model: User.self, database: .psql)
    migrations.add(model: RefreshToken.self, database: .psql)
    
    services.register(migrations)
}
