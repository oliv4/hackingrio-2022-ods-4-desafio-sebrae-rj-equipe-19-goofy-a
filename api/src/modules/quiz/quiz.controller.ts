import {
  Body,
  Controller,
  Get,
  Post,
  UseGuards,
  Request,
  Param,
} from '@nestjs/common';
import { ApiBearerAuth, ApiBody, ApiParam, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { EventsService } from '../events/events.service';
import { QuizEntity } from './entities/quiz.entity';
import { QuizQuestionAnswerModel } from './models/answers.model';
import { QuizService } from './quiz.service';

@Controller('quiz')
@ApiTags('quiz')
export class QuizController {
  constructor(
    private readonly quizService: QuizService,
    private readonly eventsService: EventsService,
  ) {}

  @Get('/:id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  public async getQuiz(@Param('id') id: string): Promise<QuizEntity> {
    const quiz = await this.quizService.getQuizById(id);
    return quiz;
  }

  @Post('/assign/:id')
  @UseGuards(JwtAuthGuard)
  @ApiBody({ type: Array<QuizQuestionAnswerModel> })
  @ApiParam({
    name: 'id',
    type: 'string',
    example: '944ce490-ed9a-4e32-9cd1-2e89d0f009c1',
  })
  @ApiBearerAuth()
  public async assignQuizAnswers(
    @Body() payload: QuizQuestionAnswerModel[],
    @Param('id') quizId: string,
    @Request() req: any,
  ): Promise<void> {
    const event = await this.eventsService.getEventByQuizId(quizId);
    await this.quizService.assignQuizAnswers(
      payload,
      quizId,
      req.user.username,
      event,
    );
  }
}
