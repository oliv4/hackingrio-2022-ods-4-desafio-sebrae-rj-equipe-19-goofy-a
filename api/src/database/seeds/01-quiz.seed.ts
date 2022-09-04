import { QuizEntity } from '../../modules/quiz/entities/quiz.entity';
import { Connection } from 'typeorm';
import { Factory, Seeder } from 'typeorm-seeding';

export default class QuizSeed implements Seeder {
  public async run(factory: Factory, connection: Connection): Promise<void> {
    await connection
      .createQueryBuilder()
      .insert()
      .into(QuizEntity)
      .values([
        {
          id: '944ce490-ed9a-4e32-9cd1-2e89d0f009c1',
          title: 'Exposição de Van Gogh',
          description:
            'Teste seus conhecimentos a cerca da exposição de Van Gogh',
          questions: [
            {
              id: 1,
              title: 'Quantas versões de "Quarto em Arles", Van Gogh pintou?',
              alternatives: [
                {
                  id: 1,
                  title: '2',
                  isCorrect: false,
                },
                {
                  id: 2,
                  title: '3',
                  isCorrect: true,
                },
                {
                  id: 3,
                  title: '1',
                  isCorrect: false,
                },
                {
                  id: 4,
                  title: '4',
                  isCorrect: false,
                },
              ],
            },
            {
              id: 2,
              title: 'Quando foi pintado "Os comedores de batata"?',
              alternatives: [
                {
                  id: 1,
                  title: '1880',
                  isCorrect: false,
                },
                {
                  id: 2,
                  title: '1885',
                  isCorrect: true,
                },
                {
                  id: 3,
                  title: '1887',
                  isCorrect: false,
                },
                {
                  id: 4,
                  title: '1882',
                  isCorrect: false,
                },
              ],
            },
            {
              id: 3,
              title: 'Em qual movimento artistico se encaixa Van Gogh?',
              alternatives: [
                {
                  id: 1,
                  title: 'Expressionismo',
                  isCorrect: false,
                },
                {
                  id: 2,
                  title: 'Pós-expressionismo',
                  isCorrect: true,
                },
                {
                  id: 3,
                  title: 'Vanguarda',
                  isCorrect: false,
                },
                {
                  id: 4,
                  title: 'Clássico',
                  isCorrect: false,
                },
              ],
            },
          ],
          finishedAt: '2022-09-10T12:00:00',
        },
      ])
      .execute();
  }
}
