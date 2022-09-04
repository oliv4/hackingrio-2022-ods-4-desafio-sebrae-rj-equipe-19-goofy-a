import { ApiProperty } from '@nestjs/swagger';

export class QuizQuestionAnswerModel {
  @ApiProperty()
  public questionId: number;
  @ApiProperty()
  public alternativeId: number;
}
