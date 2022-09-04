export interface QuizQuestionModel {
  id: number;
  title: string;
  alternatives: QuizAlternativeQuestionModel[];
}

export interface QuizAlternativeQuestionModel {
  id: number;
  title: string;
  isCorrect: boolean;
}
