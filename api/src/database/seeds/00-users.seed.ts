import { Connection } from 'typeorm';
import { Factory, Seeder } from 'typeorm-seeding';
import { UsersEntity } from '../../modules/users/users.entity';

export default class UsersSeed implements Seeder {
  public async run(factory: Factory, connection: Connection): Promise<void> {
    await connection
      .createQueryBuilder()
      .insert()
      .into(UsersEntity)
      .values([
        {
          id: 'c7c6aedd-ef12-40b6-addd-c0acc5c336b1',
          username: 'hackingrio',
          password: 'blockchain',
        },
      ])
      .execute();
  }
}
