import { ChallengeTypes } from '../../modules/events/challenge-types.enum';
import { EventChallengesEntity } from '../../modules/events/event-challenges.entity';
import { Connection } from 'typeorm';
import { Factory, Seeder } from 'typeorm-seeding';

export default class EventChallengesSeed implements Seeder {
  public async run(factory: Factory, connection: Connection): Promise<void> {
    await connection
      .createQueryBuilder()
      .insert()
      .into(EventChallengesEntity)
      .values([
        {
          id: '037e48b8-2028-4b84-8d5e-4d3fe1479762',
          challengeId: '944ce490-ed9a-4e32-9cd1-2e89d0f009c1',
          challengeType: ChallengeTypes.QUIZ,
          eventId: '2df7bfca-cfaa-4206-85ed-d9c430d243ae',
        },
      ])
      .execute();
  }
}
