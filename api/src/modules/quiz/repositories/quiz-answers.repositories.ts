import { UsersEntity } from 'src/modules/users/users.entity';
import { EntityRepository, Repository } from 'typeorm';
import { QuizAnswersEntity } from '../entities/quiz-answers.entity';
import { QuizEntity } from '../entities/quiz.entity';
import { QuizQuestionAnswerModel } from '../models/answers.model';

@EntityRepository(QuizAnswersEntity)
export class QuizAnswersRepository extends Repository<QuizAnswersEntity> {
  public async assignQuizAnswers(
    answers: QuizQuestionAnswerModel[],
    score: number,
    quiz: QuizEntity,
    user: UsersEntity,
  ) {
    const quizAnswers = await this.save({
      answers,
      score,
      user,
      quiz,
    });
    return quizAnswers;
  }

  public async findByUserAndQuiz(
    user: UsersEntity,
    quiz: QuizEntity,
  ): Promise<QuizAnswersEntity> {
    const quizAnswers = await this.findOne({
      where: {
        user,
        quiz,
      },
    });
    return quizAnswers;
  }
}
