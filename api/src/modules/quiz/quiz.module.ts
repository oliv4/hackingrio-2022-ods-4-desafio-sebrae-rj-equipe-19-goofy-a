import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { QuizController } from './quiz.controller';
import { QuizRepository } from './repositories/quiz.repository';
import { QuizService } from './quiz.service';
import { UsersModule } from '../users/users.module';
import { QuizAnswersRepository } from './repositories/quiz-answers.repositories';
import { BlockchainModule } from '../blockchain/blockchain.module';
import { BadgesModule } from '../badges/badge.module';
import { EventsModule } from '../events/events.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([QuizRepository, QuizAnswersRepository]),
    UsersModule,
    BlockchainModule,
    BadgesModule,
    EventsModule,
  ],
  controllers: [QuizController],
  providers: [QuizService],
  exports: [QuizService],
})
export class QuizModule {}
