import { EntityRepository, Repository } from 'typeorm';
import { QuizEntity } from '../entities/quiz.entity';

@EntityRepository(QuizEntity)
export class QuizRepository extends Repository<QuizEntity> {
  public async findById(id: string): Promise<QuizEntity> {
    const quiz = await this.findOne({
      where: { id },
    });
    return quiz;
  }
}
