import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { QuizAlternativeQuestionModel } from './models/questions.model';
import { QuizEntity } from './entities/quiz.entity';
import { QuizRepository } from './repositories/quiz.repository';
import { UsersService } from '../users/users.service';
import { QuizQuestionAnswerModel } from './models/answers.model';
import { QuizAnswersRepository } from './repositories/quiz-answers.repositories';
import { BadgesService } from '../badges/badge.service';
import { WalletsService } from '../blockchain/wallets.service';
import { NFTProvider } from '../blockchain/providers/nft.provider';
import { EventsEntity } from '../events/events.entity';

@Injectable()
export class QuizService {
  constructor(
    @InjectRepository(QuizRepository)
    private readonly quizRepository: QuizRepository,
    @InjectRepository(QuizAnswersRepository)
    private readonly quizAnswersRepository: QuizAnswersRepository,
    private readonly usersService: UsersService,
    private readonly badgesService: BadgesService,
    private readonly walletsService: WalletsService,
    private readonly nftProvider: NFTProvider,
  ) {}

  public async findById(id: string): Promise<QuizEntity> {
    const quiz = await this.quizRepository.findById(id);
    if (!quiz) throw new NotFoundException('Quiz not found');
    return quiz;
  }

  public async assignQuizAnswers(
    answers: QuizQuestionAnswerModel[],
    quizId: string,
    username: string,
    event: EventsEntity,
  ): Promise<any> {
    const quiz = await this.findById(quizId);
    const user = await this.usersService.findUserByUsername(username);

    const userHasDone = await this.quizAnswersRepository.findByUserAndQuiz(
      user,
      quiz,
    );
    if (userHasDone) {
      throw new ForbiddenException(
        'User cannot answer same quiz more than once',
      );
    }

    let wallet = await this.walletsService.findWalletByUserId(user.id);
    if (!wallet) wallet = await this.walletsService.createWallet(user.id);

    let score = 0;
    try {
      answers.map((answer) => {
        const question = quiz.questions.filter(
          (question) => question.id === answer.questionId,
        )[0];
        const correctAnswer = question.alternatives.filter(
          (alternative) => alternative.isCorrect === true,
        )[0];
        if (correctAnswer.id === answer.alternativeId) score++;
      });

      await this.quizAnswersRepository.assignQuizAnswers(
        answers,
        score,
        quiz,
        user,
      );
      const nft = await this.nftProvider.mint(wallet.address, event.badgeUri);
      await this.badgesService.createBadge(user.id, event.id, nft);
    } catch {
      throw new BadRequestException('Wrong payload format');
    }
  }

  /**
   * @param id quiz id
   * @returns quiz without isCorrect value on alternative
   */
  public async getQuizById(id: string): Promise<QuizEntity> {
    const quiz = await this.findById(id);

    quiz.questions = quiz.questions.map((question) => {
      question.alternatives = question.alternatives.map((alternative) => {
        return {
          id: alternative.id,
          title: alternative.title,
        };
      }) as QuizAlternativeQuestionModel[];
      return question;
    });

    return quiz;
  }
}
