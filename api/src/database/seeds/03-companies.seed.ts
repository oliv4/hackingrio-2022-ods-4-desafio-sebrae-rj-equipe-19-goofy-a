import { CompaniesEntity } from '../../modules/companies/companies.entity';
import { Connection } from 'typeorm';
import { Factory, Seeder } from 'typeorm-seeding';

export default class CompaniesSeed implements Seeder {
  public async run(factory: Factory, connection: Connection): Promise<void> {
    await connection
      .createQueryBuilder()
      .insert()
      .into(CompaniesEntity)
      .values([
        {
          id: 'b4fb38ca-f62a-471d-8279-3726f18a253c',
          name: 'SEBRAE',
          logo: 'https://logodownload.org/wp-content/uploads/2014/09/sebrae-logo-0-2048x2048.png',
        },
        {
          id: '0458a80f-1b8f-4a99-91a8-24764b1be7b0',
          name: 'Prefeitura do Rio de Janeiro',
          logo: 'https://site.prefeitura.rio/wp-content/uploads/sites/77/2022/08/logopref.c5f0ea3e-1-1.png',
        },
        {
          id: 'b17495bd-803a-4647-afac-34bb38d98080',
          name: 'Governo do estado do Rio de Janeiro',
          logo: 'https://logodownload.org/wp-content/uploads/2018/08/governo-do-estado-rio-de-janeiro-logo-1-1.png',
        },
      ])
      .execute();
  }
}
