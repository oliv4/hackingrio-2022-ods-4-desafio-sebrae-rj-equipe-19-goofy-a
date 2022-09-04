module.exports = {
  type: 'postgres',
  host: process.env.DATABASE_HOST || 'localhost',
  port: 5432,
  username: process.env.DATABASE_USERNAME,
  password:  process.env.DATABASE_PASSWORD,
  database: process.env.DATABASE_SCHEMA,
  entities: [`${__dirname}/../**/*.entity.{ts,js}`],
  synchronize: false,
  autoLoadEntities: false,
  migrationsTableName: 'migration',
  migrations: ['src/database/migrations/**/*.ts'],
  subscribers: ['src/database/subscribers/**/*.ts'],
  factories: ['src/database/factories/**/*{.ts,.js}'],
  seeds: ['src/database/seeds/**/*.seed{.ts,.js}'],
  cli: {
    migrationsDir: 'src/database/migrations',
    subscribersDir: 'src/database/subscribers',
  },
  logging: true,
  ssl: process.env.NODE_ENV === 'development' ? false : { require: true, rejectUnauthorized: false }
};
