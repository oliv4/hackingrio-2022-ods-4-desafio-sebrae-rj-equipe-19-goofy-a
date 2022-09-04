import { EventsEntity } from '../../modules/events/events.entity';
import { Connection } from 'typeorm';
import { Factory, Seeder } from 'typeorm-seeding';

export default class EventsSeed implements Seeder {
  public async run(factory: Factory, connection: Connection): Promise<void> {
    await connection
      .createQueryBuilder()
      .insert()
      .into(EventsEntity)
      .values([
        {
          id: '2df7bfca-cfaa-4206-85ed-d9c430d243ae',
          title: 'Van Gogh no Metaverso',
          description:
            'Já imaginou estar em uma exposição com todos os quadros do Van Gogh? Participe agora da nossa exposição imersiva: Van Gogh no Metaverso',
          metaverseLink: 'link.com',
          sponsorId: 'b4fb38ca-f62a-471d-8279-3726f18a253c',
          finishedAt: '2022-09-10T12:00:00',
          badgeUri:
            'https://gateway.pinata.cloud/ipfs/QmREVAGkWUDPpJ4rskCDCrG738B9bssqdR9SbUWHP9GNt1',
          bannerUrl: 'https://www.prensalatina.com.br/wp-content/uploads/2022/05/Van-Gogh.jpg'
        },
      ])
      .execute();
  }
}
