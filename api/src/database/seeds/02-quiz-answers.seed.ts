import { Connection } from 'typeorm';
import { Factory, Seeder } from 'typeorm-seeding';
import { QuizAnswersEntity } from '../../modules/quiz/entities/quiz-answers.entity';

export default class QuizAswersSeed implements Seeder {
  public async run(factory: Factory, connection: Connection): Promise<void> {
    await connection
      .createQueryBuilder()
      .insert()
      .into(QuizAnswersEntity)
      .values([])
      .execute();
  }
}
